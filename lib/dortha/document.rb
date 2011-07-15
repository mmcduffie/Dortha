module Dortha
  # The Document class represents a Dortha source file, and contains
  # methods that operate on each source file, including the lexer.
  class Document < Array
    # Creates a new Document. Document is a subclass of Array, so we have to call
    # super in our initializer for it to create an Array with our data.
    def initialize(source_file)
      super
      @line_count = 0
    end
    
    # The lex method is a lexer that takes all of the lines in the source file and 
    # converts each word into a Token object.
    def lex
      self.map! {|line| line = [line] }
      self.each_with_index do |line,line_number|
        unless line_number == 0
          line_string = line[0]
          line_string.lstrip!
          until line_string.empty?
            strip_and_add_tokens(line_string,line_number)
          end
          line.shift
        end
        @line_count += 1
      end
    end
    
    private
    
      # line_count is incremented by the lexer as it converts lines to token objects.
      # it should reflect the total number of lines in the source file.
      attr_accessor :line_count

      # strip_and_add_tokens is a small but important factor in the work that the lex
      # method does. it is responsible for removing parts of the original strings from
      # each line in the source file, converting them into tokens, and then pushing them
      # back unto the Document array.
      def strip_and_add_tokens(line_string,line_number)
        if line_string.match(/^\"/)
          strip_quoted_token(line_number)
        elsif line_string.match(/\s/)
          strip_plain_token(line_number)
        else
          strip_single_token(line_number)
        end
      end
      
      # add_token takes a string and converts it to a token object. Then, it pushes
      # the object back unto the line.
      def add_token(token_string,line_number,string=false)
        if string
          token = Dortha::String.new(token_string,line_number)
        else
          token = Dortha::Token.new(token_string,line_number)
        end
        self[line_number].push(token)
      end
      
      # strip_single_token is used when there is only one word on a given line.
      # the word is removed from the line and replaced with a Token object.
      def strip_single_token(line_number)
        line = self[line_number]
        token_string = line[0].slice!(0,line[0].length)
        add_token(token_string,line_number)
      end
    
      # strip_plain_token is used when a line contains more than one token that is
      # not a double-quoted string. It will remove the token and replace it with a
      # Token object.
      def strip_plain_token(line_number)
        line = self[line_number]
        space_index = line[0].index(/\s/)
        token_string = line[0].slice!(0,space_index)
        line[0].lstrip!
        add_token(token_string,line_number)
      end
      
      # strip_quoted_token is used when the string we are converting to objects starts 
      # with a double quote. This way, the lexer can make the entire quoted string into
      # one token object, which is actualy going to be an object of the string class.
      # this is the only data type that the lexer creates. The rest will be created by
      # the interpreter.
      def strip_quoted_token(line_number)
        line = self[line_number]
        line[0].slice!(0)
        ending_quote = line[0].index(/\"/)
        token_string = line[0].slice!(0,ending_quote + 1)
        line[0].lstrip!
        token_string.chomp!(34.chr)
        add_token(token_string,line_number,true)
      end
  end
end