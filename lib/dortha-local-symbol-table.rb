class LocalSymbolTable
	def initialize
		@table = []
	end
	def addVariable(object)
		@table.push(object)
	end
end