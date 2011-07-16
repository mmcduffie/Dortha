module Dortha
  # The List class is Dortha's 'user-friendly' version of an array.
  # The List data type can be a list of objects of any type and is
  # not zero-indexed like arrays in other languages. That is, the 
  # index of the first element is '1'.
  class List
    
    def initialize(value=nil,line_number=nil)
      @value = []
      value.each do |item|
        @value.push(item)
      end
      @line_number = line_number
    end
    
    attr_accessor :value
    attr_accessor :line_number
    
    # set_values is used by the interpreter to set the value of the List.
    def set_values(*items)
      items = *items
      @value = [nil]
      items.each do |item|
        @value.push(item)
      end
    end
  end
end