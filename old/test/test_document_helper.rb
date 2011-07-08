require '../lib/document_helper.rb'
require '../lib/dortha-interpreter.rb'
require 'test/unit'

class DocumentHelperTest < Test::Unit::TestCase
	def setup
		testArray = ["test"] # This array doesn't matter for these tests.
		@document = Document.new(testArray)
	end
	def test_convertTokenToObject
		test = @document.convertTokenToObject("1",1).value
		assert_equal(1,test,"Creating object of number type should return a number.")
		test = @document.convertTokenToObject("1",1)
		assert_equal(1,test.lineNumber,"Object should have line number.")
		test = @document.convertTokenToObject("1",4)
		assert_equal(4,test.lineNumber,"Object should have line number, even if it's not line one.")
		test = @document.convertTokenToObject("0",1).value
		assert_equal(0,test,"Creating object of number type should return a number even if it's zero.")
		test = @document.convertTokenToObject("method",1).value
		assert_equal("method",test,"When token is a keyword, a keyword type object should be returned.")
		test = @document.convertTokenToObject("method",1).class
		assert_equal(DorthaKeywordType,test,"Keyword type object should be returned.")
		test = @document.convertTokenToObject("foo",1).value
		assert_equal("foo",test,"If nothing else, object of type 'other' be returned.")
	end
end