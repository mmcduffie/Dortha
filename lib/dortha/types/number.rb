module Dortha
  # Dortha only has one numeric data type, Number, with the hopes that
  # this will make the language simpler. The Dortha Number class is not 
  # a subclass of Ruby's built-in Float class, since subclassing Float does 
  # not leave us with a constructor. So, we just create a new Float when 
  # we create an object of this class.
  class Number
    include Callable
    
    # When we create a new Number, it attempts to convert the value provided
    # to a Float. If it can't Ruby will raise an exception.
    def initialize(value=nil)
      @value = Float(value)
      @SENTENCE_SIGNATURES = { :add => /add \S+ to/ }
    end
    
    attr_accessor :value
    
    def add(number)
      result = self.value + number[0].value
      self.value = result
    end
  end
end