module Dortha
  class Variable
    def initialize(value=nil,line_number=nil)
      @value = value
      @line_number = line_number
    end
    attr_accessor :value
    attr_accessor :line_number
	attr_accessor :scope
  end
end