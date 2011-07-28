module Dortha
  # The Document class represents a Dortha source file, and contains
  # methods that operate on each source file, including the lexer.
  class Document < Array
    # Creates a new Document. To create a new Document you need to 
    # provide the initalizer with a string.
    def initialize (source_file)
      unless source_file.match(/\.\Z/)
        raise Dortha::SyntaxError, "Dortha programs must end with a period."
      end
      code = source_file.gsub!(/(\n|\r)/,"").split(".")
      super(code)
      @temp_sentence_holder = []
    end
    
    # The lex method is a lexer that takes all of the sentences in the source file and 
    # converts each word into a Token object.
    def lex
      remove_leading_whitespace
      compact_remaining_whitespace
      add_sentence_objects
      self.each_with_index do |line,line_number|
        line.lstrip!
        until line.empty?
          strip_and_add_tokens(line,line_number)
        end
      end
      self.replace @temp_sentence_holder
    end
    
    private
    
    # The remove_whitespace method deletes leading whitespace from sentences.
    def remove_leading_whitespace
      self.map! { |sentence| sentence = sentence.lstrip }
    end
    
    # The compact_remaining_whitespace method finds whitespace more than one character
    # long in the middle of sentences and replaces it with single spaces.
    def compact_remaining_whitespace
      self.map! { |sentence| sentence = sentence.gsub(/\s{2,}/," ") }
    end
    
    # The add_sentence_objects method is used to seed our document with Sentence objects,
    # which are Arrays that we can add Token objects to later.
    def add_sentence_objects
      length = self.length
      length.times do
        @temp_sentence_holder.push(Dortha::Sentence.new)
      end
    end
    
    # add_token takes a string and converts it to a token object. Then, it pushes
    # the object unto a temporary array.
    def add_token(token_string,line_number,string=false)
      if string
        token = Dortha::String.new(token_string,line_number)
      else
        token = Dortha::Token.new(token_string,line_number)
      end
      @temp_sentence_holder[line_number].push(token)
    end
    
    # strip_and_add_tokens is a small but important factor in the work that the lex
    # method does. it is responsible for removing parts of the original strings from
    # each line in the source file, converting them into tokens, and then pushing them
    # into a temporary array.
    def strip_and_add_tokens(line_string,line_number)
      if line_string.match(/^\"/)
        strip_quoted_token(line_number)
      elsif line_string.match(/\s/)
        strip_plain_token(line_number)
      else
        strip_single_token(line_number)
      end
    end
    
    # strip_single_token is used when there is only one word on a given line.
    # the word is removed from the line and a Token object is created.
    def strip_single_token(line_number)
      line = self[line_number]
      token_string = line.slice!(0,line.length)
      add_token(token_string,line_number)
    end
    
    # strip_plain_token is used when a line contains more than one token that is
    # not a double-quoted string. It will remove the token and create a Token object.
    def strip_plain_token(line_number)
      line = self[line_number]
      space_index = line.index(/\s/)
      token_string = line.slice!(0,space_index)
      line.lstrip!
      add_token(token_string,line_number)
    end
    
    # strip_quoted_token is used when the string we are converting to objects starts
    # with a double quote. This way, the lexer can make the entire quoted string into
    # one token object, which is actualy going to be an object of the string class.
    # this is the only data type that the lexer creates. The rest will be created by
    # the interpreter.
    def strip_quoted_token(line_number)
      line = self[line_number]
      line.slice!(0)
      ending_quote = line.index(/\"/)
      token_string = line.slice!(0,ending_quote + 1)
      line.lstrip!
      token_string.chomp!(34.chr)
      add_token(token_string,line_number,true)
    end
  end
end