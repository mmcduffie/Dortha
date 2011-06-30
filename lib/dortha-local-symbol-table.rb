# The local symbol table is where Dortha stores objects so that they can be assosiated 
# with the local scope. The interpreter puts local variables into the local symbol 
# table as it sees them declared. When ever the interpreter changes scope, it should
# invoke the clear method to empty the local symbol table.

class LocalSymbolTable
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
	def clear
		@table.clear
	end
end