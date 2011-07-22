module Dortha
  # The Document class represents a Dortha source file, and contains
  # methods that operate on each source file, including the lexer.
  class Document < Array
    # Creates a new Document. Document is a subclass of Array, so we have to call
    # super in our initializer for it to create a Array with our data.
    def initialize(source_file)
      code = source_file.gsub!(/(\n|\r)/,"").split(".")
      super(code)
    end
    
    # The lex method is a lexer that takes all of the lines in the source file and 
    # converts each word into a Token object.
    def lex
    end
  end
end