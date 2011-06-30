# The global symbol table is where Dortha stores objects of the the variable
# type so that they can be assosiated with the global scope. The interpreter
# puts global variables into the global symbol table as it sees them declared.

class GlobalSymbolTable
	def initialize
		@table = []
	end
	def addVariable(object)
		@table.push(object)
	end
	def lookup(name)
		found = nil
		@table.each do |variable|
			if variable.name == name
				found = variable
			end
		end
		return found
	end
end