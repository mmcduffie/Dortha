require '../lib/dortha-global-symbol-table.rb'
require 'test/unit'

class GlobalSymbolTableTest < Test::Unit::TestCase
	def setup
		@table = GlobalSymbolTable.new
	end
	def test_addVariable
		token = DorthaNumberType.new(1,1)
		token.name = "testvar"
		@table.addVariable(token)
		test = @table.lookup("testvar")
		assert_equal("testvar",test.name,"Variable should be added with the name we expect.")
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