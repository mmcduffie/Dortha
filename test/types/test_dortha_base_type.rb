require '../lib/types/dortha-base-type.rb'
require 'test/unit'

class DorthaBaseTypeTest < Test::Unit::TestCase
	def setup
		@baseType = DorthaBaseType.new
	end
	def test_typeChecks
		# The type base class has methods the the other types will override.
		# these are all false in the base class.
		test = @baseType.number?
		assert_equal(false,test)
		test = @baseType.string?
		assert_equal(false,test)
		test = @baseType.array?
		assert_equal(false,test)
		test = @baseType.keyword?
		assert_equal(false,test)
		test = @baseType.variable?
		assert_equal(false,test)
		test = @baseType.other?
		assert_equal(false,test)
	end
	def test_value
		@baseType.value = "test"
		test = @baseType.value
		assert_equal("test",test,"Instance of type should have value we set.")
	end
	def test_lineNumber
		@baseType.lineNumber = 2
		test = @baseType.lineNumber
		assert_equal(2,test,"Instance of type should have line number we set.")
	end
end