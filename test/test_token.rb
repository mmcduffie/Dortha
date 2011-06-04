require '../lib/dortha-token.rb'
require '../lib/dortha-token-stack.rb'
require 'test/unit'

class TokenTest < Test::Unit::TestCase
	def setup
		@stack = TokenStack.new
		@token = Token.new(@stack)
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
		lineNumbers = @stack.lineNumbers
		tokens = @stack.tokens
		assert_equal(1,lineNumbers[0],"Line number is incorrect")
		assert_equal("foo",tokens[0],"Token value is incorrect")
		@token.lineNumber = 2
		@token.value = "bar"
		@token.save
		lineNumbers = @stack.lineNumbers
		tokens = @stack.tokens
		assert_equal(2,lineNumbers[1],"Line number is incorrect")
		assert_equal("bar",tokens[1],"Token value is incorrect")
	end
end