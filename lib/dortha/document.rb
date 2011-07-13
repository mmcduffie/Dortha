module Dortha
  # The Document class represents a Dortha source file, and contains
  # methods that operate on each source file, including the lexer.
  class Document < Array
    # Creates a new Document. Document is a subclass of Array, so we have to call
    # super in our initializer for it to create an Array with our data.
    def initialize(source_file)
      super
    end
	# strip_single_token is used when there is only one word left on a given line.
	# the word is removed from the line and replaced with a Token object.
    def strip_single_token(line_number)
      token_length = self[line_number].length
      token_string = self[line_number].slice!(0,token_length)
      token = Dortha::Token.new(token_string,line_number)
      self[line_number] = [token]
    end
  end
end