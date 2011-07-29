module Dortha
  # The Sentence class represents sentences in the Program. This is the first place
  # that Dortha does interpreter-type work, in the 'interpret' method of this
  # class. A sentence is an array of Token objects. Token objects are going to be
  # converted by methods in this class into objects of other types and then 
  # executed to do actual work.
  class Sentence < Array
    
    attr_accessor :current_program
    attr_accessor :value
    
    # The 'contains_value?' method searches a sentence and returns true if a object
    # with the given value is found.
    def contains_value?(value_to_find)
      results = self.select { |object| object.value == value_to_find }
      if results.empty?
        return false
      elsif results.length > 0
        return true
      end
    end
    
    def interpret(program)
      @current_program = program
      detect_keywords
      detect_number_types
      if starts_with_keyword?
        method_to_call = match_sentence_signature
        unless method_to_call == nil
          send method_to_call
        end
      end
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
    
    # The set_variable method is used to set the value of already-defined variables.
    def set_variable
      variable_name = self[1]
      global_variable_list = @current_program.global_variable_list
      global_variable_list[variable_name] = self[4].value
    end
    
    # The create_variable method creates new variables that will later have thier values
    # set by the set_variable method.
    def create_variable
      scope = @current_program.scope
      if scope == :global
        global_variable_list = @current_program.global_variable_list
        global_variable_list[self[2]] = nil
      end
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
  end
end