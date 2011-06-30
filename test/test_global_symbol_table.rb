require '../lib/dortha-global-symbol-table.rb'
require 'test/unit'

# The global symbol table is where Dortha stores objects of the the variable
# type so that they can be assosiated with the global scope. The interpreter
# puts global variables into the global symbol table as it sees them declared.

class GlobalSymbolTableTest < Test::Unit::TestCase
	def setup
		@table = GlobalSymbolTable.new
	end
	def test_addVariable
		token = DorthaNumberType.new(1,1)
		@table.addVariable(token)
	end
	def test_lookup
		token = DorthaVariableType.new("globalVariable",1)
		token.name = "globVar"
		@table.addVariable(token)
		test = @table.lookup("globVar")
		assert_equal(token,test,"Variable is not the one we put in the symbol table.")
		test = @table.lookup("foo")
		assert_equal(nil,test,"Lookup should return nil when we don't find anything.")
	end
end