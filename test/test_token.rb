require '../lib/dortha-token.rb'
require '../lib/dortha-token-stack.rb'
require 'test/unit'

class TokenTest < Test::Unit::TestCase
	def setup
		@store = TokenStore.new
		@token = Token.new(@stack,@store)
	end
	def test_lineNumber
		@token.lineNumber = 1
		assert_equal(1,@token.lineNumber,"Token line number is incorrect.")
	end
	def test_value
		@token.value = "foo"
		assert_equal("foo",@token.value,"Token value is incorrect.")
	end
	def test_save
		@token.lineNumber = 1
		@token.value = "foo"
		@token.save
		testToken = @store.tokenStore[1][0] # Line 2, Token 1.
		assert_equal("foo",testToken,"The token should be 'foo'")
		@token.lineNumber = 2
		@token.value = "bar"
		@token.save
		testToken = @store.tokenStore[2][0] # Line 3, Token 1.
		assert_equal("bar",testToken,"The token should be 'bar'")
	end
end