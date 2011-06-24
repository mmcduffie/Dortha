require '../lib/types/dortha-array-type.rb'
require 'test/unit'

class DorthaArrayTypeTest < Test::Unit::TestCase
	def setup
		@array = DorthaArrayType.new("test",1)
	end
	def test_typeChecks
		test = @array.number?
		assert_equal(false,test)
		test = @array.string?
		assert_equal(false,test) 
		test = @array.array?
		assert_equal(true,test) # Objects of type array should only respond true to this.
		test = @array.keyword?
		assert_equal(false,test)
		test = @array.variable?
		assert_equal(false,test)
		test = @array.other?
		assert_equal(false,test)
	end
	def test_value
		test = @array.value
		assert_equal("test",test,"This string object should have the value we set.")
	end
end