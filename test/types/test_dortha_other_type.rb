require '../lib/types/dortha-other-type.rb'
require 'test/unit'

class DorthaOtherTypeTest < Test::Unit::TestCase
	def setup
		@other = DorthaOtherType.new("other")
	end
	def test_typeChecks
		test = @other.number?
		assert_equal(false,test)
		test = @other.string?
		assert_equal(false,test) 
		test = @other.array?
		assert_equal(false,test) 
		test = @other.keyword?
		assert_equal(false,test) 
		test = @other.variable?
		assert_equal(false,test)
		test = @other.other?
		assert_equal(true,test) # Objects of type other should only respond true to this.
	end
	def test_value
		test = @other.value
		assert_equal("other",test,"This other object should have the value we set.")
	end
end