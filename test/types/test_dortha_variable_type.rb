require '../lib/types/dortha-variable-type.rb'
require 'test/unit'

class DorthaVariableTypeTest < Test::Unit::TestCase
	def setup
		@variable = DorthaVariableType.new("data",1)
	end
	def test_typeChecks
		test = @variable.number?
		assert_equal(false,test)
		test = @variable.string?
		assert_equal(false,test) 
		test = @variable.array?
		assert_equal(false,test) 
		test = @variable.keyword?
		assert_equal(false,test)
		test = @variable.variable?
		assert_equal(true,test) # Objects of type keyword should only respond true to this.
		test = @variable.other?
		assert_equal(false,test)
	end
	def test_value
		test = @variable.value
		assert_equal("data",test,"This variable object should have the value we set.")
	end
end