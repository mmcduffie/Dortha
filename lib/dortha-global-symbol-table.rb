class GlobalSymbolTable
	def initialize
		@table = []
	end
	def addVariable(value)
		@table.push(value)
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