require '../lib/dortha-global-symbol-table.rb'
require 'test/unit'

class GlobalSymbolTableTest < Test::Unit::TestCase
	def setup
		@table = GlobalSymbolTable.new
	end
	def test_addVariable
		@table.addVariable("globalVariable",1,1)
	end
end