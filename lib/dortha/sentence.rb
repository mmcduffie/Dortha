module Dortha
  # The Sentence class represents sentences in the Program. This is the first place
  # that Dortha does interpreter-type work, in the 'interpret' method of this
  # class. A sentence is an array of Token objects. Token objects are going to be
  # converted by methods in this class into objects of other types and then 
  # executed to do actual work.
  class Sentence < Array
  
    attr_accessor :value
    
    # The 'contains_value?' method searches a sentence and returns true if a object
    # with the given value is found.
    def contains_value?(value_to_find)
      results = self.select { |object| object.value == value_to_find }
      if results.empty?
        return false
      elsif results.length > 0
        return true
      end
    end
    
    def interpret
      detect_keywords
      detect_number_types
      if self.create?
        create_objects
      end
    end
    
    # The detect_keywords method scans a Sentence of tokens for Tokens that can
    # be turned into Keywords. If it finds them, in converts them to Keyword type
    # objects.
    def detect_keywords
      self.map! do |token|
        token = Dortha::Keyword.new(token.value) rescue token = token
      end
    end
    
    # The detect_number_types method scans a Sentence of tokens for Tokens that can
    # be turned into Numbers. If it finds them, in converts them to Number type
    # objects.
    def detect_number_types
      self.map! do |token|
        token = Dortha::Number.new(token.value) rescue token = token
      end
    end
    
    def create?
      return true if self[0].class == Dortha::Keyword && self[0].value == "create"
    end
    
    def create_objects
      if self[1].class == Dortha::Keyword && self[1].value == "variable"
      
      else
        raise "The create keyword must be followed by 'variable', 'method', 'class', or 'list.'"
      end
    end
  end
end