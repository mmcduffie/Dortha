require '../lib/dortha-local-symbol-table.rb'
require 'test/unit'

# The local symbol table is where Dortha stores objects so that they can be assosiated 
# with the local scope. The interpreter puts local variables into the local symbol 
# table as it sees them declared. When ever the interpreter changes scope, it should
# invoke the clear method to empty the local symbol table.

class LocalSymbolTableTest < Test::Unit::TestCase
	def setup
		@table = LocalSymbolTable.new
	end
	def test_addVariable
		object = DorthaNumberType.new(1,1)
		@table.addVariable(object)
	end
end