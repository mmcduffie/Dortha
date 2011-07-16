module Dortha
  # The Line class represents lines in the Program. This is the first place
  # that Dortha does interpreter-type work, in the 'interpret' method of this
  # class. A line is an array of Token objects. Token objects are going to be
  # converted by methods in this class into objects of other types and then 
  # executed to do actual work.
  class Line < Array
    def initialize(value)
      @value = value
      super
    end
    attr_accessor :value
    # The 'contains_value?' method searches a line and returns true if a object
    # with the given value is found.
    def contains_value?(value_to_find)
      results = self.select { |object| object.value == value_to_find }
      if results.empty?
        return false
      elsif results.length > 0
        return true
      end
    end
  end
end