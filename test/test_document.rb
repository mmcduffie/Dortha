require '../lib/dortha-document.rb'
require 'test/unit'

class DocumentTest < Test::Unit::TestCase
	def setup # Provided document should be an array representing lines from the source file, with newlines removed.
		testArray = ["  test1 nexttTest1","test2 \"nextTest2\"","test3 [nextTest3]"] # Notice leading spaces.
		@document = Document.new(testArray)
	end
	def test_newDocument
		assert(@document) # Make sure object creation succeeded.
		assert(@document.kind_of?(Array)) # Document is supposed to be a subclass of Array.
		assert_not_nil(@document.tokenStack) # Should have a tokenStack to work with.
	end
	def test_lineCount
		assert_equal(0,@document.lineCount,"lineCount is supposed to start at zero.")
	end
	def test_parse
		@document.parse
		testLineNumbers = @document.tokenStack.lineNumbers
		testLineNumber = testLineNumbers[3] # The fourth token.
		assert_equal(1,testLineNumber,"The fourth token should be on line 2.") # Line numbers start at zero.
		testTokens = @document.tokenStack.tokens
		testToken = testTokens[3] # The fourth token.
		assert_equal("\"nextTest2\"",testToken,"The fourth token should be \"nextTest2\".") # Line numbers start at zero.
		assert_equal(3,@document.lineCount,"lineCount should be three.")
		testToken = @document.tokenStack.popToken
		assert_equal({"lineNumber" => 2, "value" => "[nextTest3]", "receiver" => true},testToken,"receiver must be true.")
	end
	def test_stripSingleToken
		testLine = ['Token']
		@document = Document.new(testLine)
		@document.stripSingleToken(0) # This method expects a line number. We'll give it zero.
		assert_equal([""],@document,"Token not striped.")
		assert_equal(["Token"],@document.tokenStack.tokens,"Token on stack does not match what we put in.")
	end
	def test_stripPlainToken
		testLine = ['Token  AnotherToken'] # Notice there are two spaces in the middle of this line.
		@document = Document.new(testLine)
		@document.stripPlainToken(0) # This method expects a line number. We'll give it zero.
		assert_equal(["AnotherToken"],@document,"Token not striped.")
		assert_equal(["Token"],@document.tokenStack.tokens,"Token on stack does not match what we put in.")
	end
	def test_stripQuotedToken
		testLine = ['"Quoted Token"  non-quoted-token'] # Notice there are two spaces in the middle of this line.
		@document = Document.new(testLine)
		@document.stripQuotedToken(0) # This method expects a line number. We'll give it zero.
		assert_equal(["non-quoted-token"],@document,"Quoted token not striped.")
		assert_equal(["\"Quoted Token\""],@document.tokenStack.tokens,"Token on stack does not match what we put in.")
	end
	def test_stripBraketedToken
		testLine = ['[Braket Token]  non-braket-token'] # Notice there are two spaces in the middle of this line.
		@document = Document.new(testLine)
		@document.stripBraketedToken(0) # This method expects a line number. We'll give it zero.
		assert_equal(["non-braket-token"],@document,"Braketed token not striped.")
		assert_equal(["[Braket Token]"],@document.tokenStack.tokens,"Token on stack does not match what we put in.")
	end
end