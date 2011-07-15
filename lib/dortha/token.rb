module Dortha
  # The Token class is a class of objects created by the lexer from our
  # source file. Every word in the source except for double quoted stings 
  # gets turned into a token object. Later, the interpreter will convert
  # these token objects into objects of other types.
  class Token
    def initialize(value=nil,line_number=nil)
      @value = value
      @line_number = line_number
    end
    # Value represents the data contained on each token object. These may be
    # numbers, keywords, or variable symbols, but the interpreter will decide
    # that when it reads each token.
    attr_accessor :value
  end
end