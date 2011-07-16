module Dortha
  # Dortha only has one numeric data type, Number, with the hopes that
  # this will make the language simpler. The Dortha Number class is not 
  # a subclass of Ruby's built-in Float class, since subclassing Float does 
  # not leave us with a constructor. So, we just create a new Float when 
  # we create an object of this class.
  class Number
    # When we create a new Number, it attempts to convert the value provided
    # to a Float. If it can't Ruby will raise an exception.
    def initialize(value=nil,line_number=nil)
      @value = Float(value)
      @line_number = line_number
    end
    attr_accessor :value
    attr_accessor :line_number
  end
end