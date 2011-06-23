require '../lib/types/dortha-number-type.rb'
require 'test/unit'

class DorthaNumberTypeTest < Test::Unit::TestCase
	def setup
		@number = DorthaNumberType.new(1)
	end
	def test_typeChecks
		test = @number.number?
		assert_equal(true,test) # Objects of type number should only respond true to this.
		test = @number.string?
		assert_equal(false,test)
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
		assert_equal(1,test,"This number object should have the value we set.")
	end
end