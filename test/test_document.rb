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
		assert_not_nil(@document.tokenStore) # Should have a tokenStore to work with.
	end
	def test_lineCount
		assert_equal(0,@document.lineCount,"lineCount is supposed to start at zero.")
	end
	def test_parse
		@document.parse
		testToken = @document.tokenStore.tokenStore[1][1] # Line 2, Token 2.
		assert_equal("nextTest2",testToken,"The fourth token should be \"nextTest2\".")
		testReceiver = @document.tokenStore.receiver(1) # Line numbers start at zero.
		assert_equal("nextTest2",testReceiver,"The receiver on line 2 should be \"nextTest2\".")
	end
	def test_stripSingleToken
		testLine = ['Token']
		@document = Document.new(testLine)
		@document.stripSingleToken(0) # This method expects a line number. We'll give it zero.
		assert_equal([""],@document,"Token not striped.")
		assert_equal(["Token"],@document.tokenStore.tokenStore[0],"Token in store does not match what we put in.")
	end
	def test_stripPlainToken
		testLine = ['Token  AnotherToken'] # Notice there are two spaces in the middle of this line.
		@document = Document.new(testLine)
		@document.stripPlainToken(0) # This method expects a line number. We'll give it zero.
		assert_equal(["AnotherToken"],@document,"Token not striped.")
		assert_equal(["Token"],@document.tokenStore.tokenStore[0],"Token in store does not match what we put in.")
	end
	def test_stripQuotedToken
		testLine = ['"Quoted Token"  non-quoted-token'] # Notice there are two spaces in the middle of this line.
		@document = Document.new(testLine)
		@document.stripQuotedToken(0) # This method expects a line number. We'll give it zero.
		assert_equal(["non-quoted-token"],@document,"Quoted token not striped.")
		assert_equal(["Quoted Token"],@document.tokenStore.tokenStore[0],"Token in store does not match what we put in.")
	end
	def test_stripBraketedToken
		testLine = ['[Braket Token]  non-braket-token'] # Notice there are two spaces in the middle of this line.
		@document = Document.new(testLine)
		@document.stripBraketedToken(0) # This method expects a line number. We'll give it zero.
		assert_equal(["non-braket-token"],@document,"Braketed token not striped.")
		assert_equal(["[Braket Token]"],@document.tokenStore.tokenStore[0],"Token in store does not match what we put in.")
	end
end