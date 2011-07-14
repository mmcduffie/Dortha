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
      convert_lines_to_arrays
      self.each_with_index do |line,line_number|
        unless line_number == 0
          line = line[0]
          line.lstrip!
          until line.empty?
            if line.match(/^\"/)
              strip_quoted_token(line_number)
            elsif line.match(/\s/)
              strip_plain_token(line_number)
            else
              strip_single_token(line_number)
            end
          end
        end
        @line_count += 1
      end
    end
    
    private
    
      # line_count is incremented by the lexer as it converts lines to token objects.
      # it should reflect the total number of lines in the source file.
      attr_accessor :line_count
      
      # convert_lines_to_arrays takes every line of the Document (with each line
      # being an element in the Document array) and turns it into an array containing
      # only that line as a string.
      def convert_lines_to_arrays
        self.each_with_index do |line,index|
          self[index] = [line]
        end
      end
    
      # strip_single_token is used when there is only one word on a given line.
      # the word is removed from the line and replaced with a Token object.
      def strip_single_token(line_number)
        line = self[line_number]
        token_string = line[0].slice!(0,line[0].length)
        token = Dortha::Token.new(token_string,line_number)
        line[0] = token
      end
    
      # strip_plain_token is used when a line contains more than one token that is
      # not a double-quoted string. It will remove the token and replace it with a
      # Token object.
      def strip_plain_token(line_number)
        line = self[line_number]
        space_index = line[0].index(/\s/)
        token_string = line[0].slice!(0,space_index)
        line[0].lstrip!
        token = Dortha::Token.new(token_string,line_number)
        line.push(token)
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
        token = Dortha::Token.new(token_string,line_number)
        line.push(token)
      end
  end
end