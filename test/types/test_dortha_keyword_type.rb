require '../lib/types/dortha-keyword-type.rb'
require 'test/unit'

class DorthaKeywordTypeTest < Test::Unit::TestCase
	def setup
		@keyword = DorthaKeywordType.new("method",1)
	end
	def test_typeChecks
		test = @keyword.number?
		assert_equal(false,test)
		test = @keyword.string?
		assert_equal(false,test) 
		test = @keyword.array?
		assert_equal(false,test) 
		test = @keyword.keyword?
		assert_equal(true,test) # Objects of type keyword should only respond true to this.
		test = @keyword.variable?
		assert_equal(false,test)
		test = @keyword.other?
		assert_equal(false,test)
	end
	def test_value
		test = @keyword.value
		assert_equal("method",test,"This keyword object should have the value we set.")
	end
end