module Dortha
  # The Program class represents the code of our program after it's been broken
  # into Tokens by the lexer. The Program will contain objects of the class Line.
  class Program < Array
    def initialize(value)
      @value = value
      super(value)
    end
    
    # Value represents the code of our program as an array of lines that are
    # themselves arrays that contain Token and String objects.
    attr_accessor :value
	
	def interpret
	  self.map! do |sentence| 
        sentence.interpret
      end
	end

  end
end