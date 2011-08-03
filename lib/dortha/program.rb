module Dortha
  # The Program class represents the code of our program after it's been broken
  # into Tokens by the lexer. The Program will contain objects of the class Line.
  class Program < Array
    def initialize(value)
      @value = value
      @global_variable_list = Hash.new
      @global_method_list = Hash.new
      @scope = :global
      super(value)
    end
    
    # Value represents the code of our program as an array of lines that are
    # themselves arrays that contain Token and String objects.
    attr_accessor :value
    
    # global_variable_table holds global variable names and thier values. Variables
    # for other scopes like methods and classes will be handled by the classes and
    # methods themselves.
    attr_accessor :global_variable_list
    
    attr_accessor :global_method_list
    attr_accessor :scope
    
    # The interpret method of Program really just calls the interpret method
    # on each sentence.
    def interpret
      self.map! do |sentence| 
        sentence.interpret(self)
      end
    end

  end
end