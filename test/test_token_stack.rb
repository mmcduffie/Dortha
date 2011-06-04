require '../lib/dortha-token-stack.rb'
require 'test/unit'

class TokenStackTest < Test::Unit::TestCase
	def setup
		@tokenStack = TokenStack.new
	end
	def test_inspect
		@tokenStack.pushToken(1,"foo")
		@tokenStack.pushToken(2,"bar")
		assert_equal("Token: foo Line: 1, Token: bar Line: 2",@tokenStack.inspect,"Output of inspect not what we wanted.")
	end
	def test_lineCount
		@tokenStack.lineCount = 3
		test = @tokenStack.lineCount
		assert_equal(3,test,"lineCount incorrect")
	end
	def test_lineNumbers
		tokenStackClass = @tokenStack.lineNumbers.class
		assert(tokenStackClass = "Array")
	end
	def test_pushToken
		@tokenStack.pushToken(1,"foo")
		testNumbers = @tokenStack.lineNumbers
		testTokens = @tokenStack.tokens
		assert_equal(1,testNumbers[0],"First line number should be one.")
		assert_equal("foo",testTokens[0],"First token should be foo.")
		@tokenStack.pushToken(1,"bar")
		nextTestNumbers = @tokenStack.lineNumbers
		nextTestTokens = @tokenStack.tokens
		assert_equal(1,nextTestNumbers[1],"Second line number should be one.") # We can have multiple tokens per line.
		assert_equal("bar",nextTestTokens[1],"Second token should be bar.")
	end
	def test_popToken
		@tokenStack.pushToken(1,"foo")
		@tokenStack.pushToken(2,"bar")
		testHash = @tokenStack.popToken
		assert_equal({"lineNumber" => 2, "value" => "bar"},testHash,"Token hash not what we expected.") # Should be hash with one token.
		testHash = @tokenStack.popToken
		assert_equal({"lineNumber" => 1, "value" => "foo"},testHash,"Token hash not what we expected.") # Should be hash with one token.
	end
end