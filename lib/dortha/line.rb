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
    
    # The detect_number_types method scans a Line of tokens for Tokens that can
    # be turned into Numbers. If it finds them, in converts them to Number type
    # objects.
    def detect_number_types
      self.map! do |token|
        token = Dortha::Number.new(token.value,1) rescue token = token
      end
    end
  end
end