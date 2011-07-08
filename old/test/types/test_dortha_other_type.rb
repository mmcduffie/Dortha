require '../lib/types/dortha-other-type.rb'
require 'test/unit'

class DorthaOtherTypeTest < Test::Unit::TestCase
	def setup
		@other = DorthaOtherType.new("other",1)
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
	def test_lineNumbers
		other1 = DorthaOtherType.new("test",1)
		other2 = DorthaOtherType.new("test",2)
		other3 = DorthaOtherType.new("test",3)
		assert_equal(1,other1.lineNumber)
		assert_equal(2,other2.lineNumber)
		assert_equal(3,other3.lineNumber)
	end
end