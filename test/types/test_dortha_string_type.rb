require '../lib/types/dortha-string-type.rb'
require 'test/unit'

class DorthaStringTypeTest < Test::Unit::TestCase
	def setup
		@number = DorthaStringType.new("test")
	end
	def test_typeChecks
		test = @number.number?
		assert_equal(false,test)
		test = @number.string?
		assert_equal(true,test) # Objects of type string should only respond true to this.
		test = @number.array?
		assert_equal(false,test)
		test = @number.keyword?
		assert_equal(false,test)
		test = @number.variable?
		assert_equal(false,test)
		test = @number.other?
		assert_equal(false,test)
	end
	def test_value
		test = @number.value
		assert_equal("test",test,"This string object should have the value we set.")
	end
end