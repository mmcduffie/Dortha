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