module Dortha
  # The Keyword class is a class of objects that represent keywords in the
  # language. Keyword objects are created when the interpret method of the 
  # Line class is invoked and the value of any given Token it finds matches
  # a list of built-in language keywords.
  class Keyword
  
    # The KEY_WORDS constant should be a globaly unique list of language 
    # keywords the system understands.
    KEY_WORDS = ["create","method","class","variable","set","show"]
    
    # If a new Keyword object is created and it's value does not match one
    # of the language keywords, a RuntimeError will be raised.
    def initialize(value=nil,line_number=nil)
      unless KEY_WORDS.include?(value)
        raise Dortha::InternalError, "#{value} is not a language keyword."
      end
      @value = value
      @line_number = line_number
    end
    
    # Value represents the data contained on each keyword object.
    attr_accessor :value
    attr_accessor :line_number
  end
end