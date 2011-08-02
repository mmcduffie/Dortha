module Dortha
  # The Sentence class represents sentences in the Program. This is the first place
  # that Dortha does interpreter-type work, in the 'interpret' method of this
  # class. A sentence is an array of Token objects. Token objects are going to be
  # converted by methods in this class into objects of other types and then 
  # executed to do actual work.
  class Sentence < Array
    
    attr_accessor :current_program
    attr_accessor :value
    
    # The Interpret method is the main interpreter for the entire Dortha implementation.
    def interpret(program)
      @current_program = program
      detect_keywords
      detect_number_types
      if starts_with_keyword?
        method_to_call = match_sentence_signature
        if method_to_call == nil
          message = "\"#{convert_sentence_to_string}\" Starts with a keyword, but does not match any of the allowed sentence forms."
          raise Dortha::SyntaxError, message
        else
          send method_to_call
        end
      else
        call_method
      end
    end

    private
    
    # The call_method method is called when a sentence that doesn't start with a
    # keyword is interpreted. The last word in any given sentence is always the
    # object the method is called on (the 'message'), and the rest of the sentence
    # is the method (or method signature) that is being called on that object.
    def call_method
      scope = @current_program.scope
      message = self[0..-2]
      receiver = self[-1..-1][0]
      if receiver.class != Dortha::Number || receiver.class != Dortha::String
        if scope == :global
          receiver = @current_program.global_variable_list[receiver.value]
        end
      end
      method_to_call = receiver.find_sentence_signature(message)
      method_signature_regexp = receiver.find_sentence_signature_regexp(method_to_call)
      argument_indices = find_argument_indices(method_signature_regexp)
      arguments = get_arguments(argument_indices)
      receiver.send(method_to_call, arguments)
    end
    
    # The detect_keywords method scans a Sentence of tokens for Tokens that can
    # be turned into Keywords. If it finds them, in converts them to Keyword type
    # objects.
    def detect_keywords
      self.map! do |token|
        token = Dortha::Keyword.new(token.value) rescue token
      end
    end
    
    # The detect_number_types method scans a Sentence of tokens for Tokens that can
    # be turned into Numbers. If it finds them, in converts them to Number type
    # objects.
    def detect_number_types
      self.map! do |token|
        token = Dortha::Number.new(token.value) rescue token
      end
    end
    
    # The starts_with_keyword? method is used to see if the first word of a sentence 
    # is a language keyword, like "create," "Method," or "class." If the first word of 
    # the sentence is a keyword, it should be handled as one of the built-in senctence 
    # templates that have special meaning in Dortha.
    def starts_with_keyword?
      return true if self[0].class == Dortha::Keyword
    end
    
    # The match_sentence_signature method attempts to match a sentance to one of Dortha's
    # built-in sentence signatures (kind of like a sentence template) and returns the
    # name of a method to call, if found.    
    def match_sentence_signature
      method_to_call = nil
      Dortha::DORTHA_METHODS.each do |key, value|
        method_to_call = key if convert_sentence_to_string.match(value)
      end
      method_to_call
    end
    
    # The convert_sentence_to_string method takes a Dortha sentence and converts it to a
    # string.
    def convert_sentence_to_string
      temp_array = []
      self.map do |token| 
        temp_array.push(token.value)
        temp_array.push(" ")
      end
      temp_array.reverse!.shift
      temp_array.reverse!
      temp_array.to_s
    end
    
    # The set_variable method is used to set the value of already-defined variables.
    def set_variable
      variable_name = self[1].value
      global_variable_list = @current_program.global_variable_list
      global_variable_list[variable_name] = self[4]
    end
    
    # The create_variable method creates new variables that will later have thier values
    # set by the set_variable method.
    def create_variable
      scope = @current_program.scope
      if scope == :global
        global_variable_list = @current_program.global_variable_list
        global_variable_list[self[2].value] = nil
      end
    end
    
    # The show_value_of method prints the value of the given variable to the screen.
    def show_value_of
      variable = @current_program.global_variable_list[self[3].value]
      puts variable.value
    end
    
    # The find_argument_indices looks at a regular expression that represents a dortha
    # sentence signature and finds which words in the sentence are arguments. Then, it
    # returns an array with the locations of all arguments in the sentence.
    def find_argument_indices(regexp)
      regexp_array = regexp.to_s[7..-2].split(/\s/)
      argument_index_array = []
      regexp_array.each_with_index do |word, index|
        if word == "\\w+" || word == "\\S+"
          argument_index_array.push(index)
        end
      end
      argument_index_array
    end
    
    # The get_arguments method parses a sentence to pull out the values of it's arguments,
    # and then returns those in an array.
    def get_arguments(argument_indices)
      argument_indices.map! do |index|
        self[index]
      end
    end
  end
end