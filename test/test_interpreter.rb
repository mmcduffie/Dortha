require '../lib/dortha-interpreter.rb'
require '../lib/dortha-document.rb'
require 'test/unit'

class InterpreterTest < Test::Unit::TestCase
	def setup # Provided document should be an array representing lines from the source file, with newlines removed.
		testArray = ["test1 middleMethod nexttTest1","test2 \"nextTest2\"","test3 [nextTest3]"] # Notice multiple methods per line.
		@document = Document.new(testArray)
		@interpreter = Interpreter.new
	end
	def test_interpret
		@document.parse
		lineCount = @document.lineCount
		@interpreter.interpret(@document.tokenStore,lineCount)
	end
	def test_call
		message = "testMethod"
		receiver = "testObject"
		testResponce = @interpreter.call(message,receiver)
		assert_equal("testObject",testResponce,"The call method should always return the object it called.")
	end
end