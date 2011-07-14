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
            #if line.match(/^\"/)
              #strip_quoted_token(line_number)
            if line.match(/\s/)
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
        line = self[line_number][0]
        token_string = line.slice!(0,line.length)
        token = Dortha::Token.new(token_string,line_number)
        self[line_number][0] = token
      end
    
      # strip_plain_token is used when a line contains more than one token that is
      # not a double-quoted string. It will remove the token and replace it with a
      # Token object.
      def strip_plain_token(line_number)
        line = self[line_number][0]
        space_index = line.index(/\s/)
        if space_index.nil?
          raise "Token is not followed by whitespace! Please use stripSingleToken instead. Line was this: #{self.inspect}"
        end
        token_string = line.slice!(0,space_index)
        while line.match(/^\s/)
          line.slice!(0)
        end
        token = Dortha::Token.new(token_string,line_number)
        self[line_number].push(token)
      end
  end
end