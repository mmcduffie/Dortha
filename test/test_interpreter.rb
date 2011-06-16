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
		message = "methods"
		receiver = Object.new # The receiver can be any ruby object.
		testResponce = @interpreter.call(message,receiver)
		assert_equal(receiver,testResponce,"The call method should always return the object it called.")
	end
	def test_withClassKeyword
		testArray = ["class TestClass"] # Since class is a keyword, putting class name in quotes is not nessasary.
		@document = Document.new(testArray)
		@interpreter = Interpreter.new
		@document.parse
		lineCount = @document.lineCount
		@interpreter.interpret(@document.tokenStore,lineCount)
		test = @interpreter.currentClass.className
		assert_equal("TestClass",test,"The class we created should have the name we expect.")
	end
	def test_withMethodKeyword
		testArray = ["method TestMethod","test1 NextTest","anotherTest"]
		@document = Document.new(testArray)
		@interpreter = Interpreter.new
		@document.parse
		lineCount = @document.lineCount
		@interpreter.interpret(@document.tokenStore,lineCount)
		testMethod = @interpreter.currentClass.instanceMethods[0]
		test = testMethod.methodName
		assert_equal("TestMethod",test,"The method we created should have the name we expect.")
		test = testMethod.methodBody
		assert_equal([["test1","NextTest"],["anotherTest"]],test,"The method we created should have the content we expect.")
	end
end