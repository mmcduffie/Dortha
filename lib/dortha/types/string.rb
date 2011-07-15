module Dortha
  # The Dortha String class is a subclass of Ruby's built-in String
  # class, with special attributes added for the interpreter's use.
  class String < String
    def initialize(value=nil,line_number=nil)
      @value = value
      @line_number = line_number
      super(value)
    end
    attr_accessor :value
    attr_accessor :line_number
  end
end