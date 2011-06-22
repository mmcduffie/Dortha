require '../lib/type_number.rb'
require 'test/unit'

class NumberTypeTest < Test::Unit::TestCase
	def setup
		@number = NumberType.new(1)
	end
	def test_objectType
		test = @number.objectType
		assert_equal("number",test,"Object should be of type number.")
	end
	def test_value
		@number.value = 2
		test = @number.value
		assert_equal(2,test,"Object should have the value we set.")
	end
end