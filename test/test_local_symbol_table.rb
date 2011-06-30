require '../lib/dortha-local-symbol-table.rb'
require 'test/unit'

class LocalSymbolTableTest < Test::Unit::TestCase
	def setup
		@table = LocalSymbolTable.new
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
	def test_clear
		token1 = DorthaStringType.new("test1",1)
		token1.name = "test1"
		@table.addVariable(token1)
		token2 = DorthaStringType.new("test2",1)
		token2.name = "test1"
		@table.addVariable(token2)
		@table.clear
		test1 = @table.lookup("test1")
		assert_equal(nil,test1,"Lookup should return nil when we've cleared the table.")
		test2 = @table.lookup("test2")
		assert_equal(nil,test2,"Lookup should return nil when we've cleared the table.")
	end
end