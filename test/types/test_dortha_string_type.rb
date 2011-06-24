require '../lib/types/dortha-string-type.rb'
require 'test/unit'

class DorthaStringTypeTest < Test::Unit::TestCase
	def setup
		@string = DorthaStringType.new("test",1)
	end
	def test_typeChecks
		test = @string.number?
		assert_equal(false,test)
		test = @string.string?
		assert_equal(true,test) # Objects of type string should only respond true to this.
		test = @string.array?
		assert_equal(false,test)
		test = @string.keyword?
		assert_equal(false,test)
		test = @string.variable?
		assert_equal(false,test)
		test = @string.other?
		assert_equal(false,test)
	end
	def test_value
		test = @string.value
		assert_equal("test",test,"This string object should have the value we set.")
	end
	def test_lineNumbers
		string1 = DorthaStringType.new("test",1)
		string2 = DorthaStringType.new("test",2)
		string3 = DorthaStringType.new("test",3)
		assert_equal(1,string1.lineNumber)
		assert_equal(2,string2.lineNumber)
		assert_equal(3,string3.lineNumber)
	end
end