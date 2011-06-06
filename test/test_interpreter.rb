require '../lib/dortha-interpreter.rb'
require '../lib/dortha-document.rb'
require 'test/unit'

class InterpreterTest < Test::Unit::TestCase
	def setup # Provided document should be an array representing lines from the source file, with newlines removed.
		testArray = ["  test1 nexttTest1","test2 \"nextTest2\"","test3 [nextTest3]"] # Notice leading spaces.
		@document = Document.new(testArray)
	end
	def test_interpret
		@document.parse
		lineCount = @document.lineCount
		@interpreter = Interpreter.new
		@interpreter.interpret(@document.tokenStack)
	end
end