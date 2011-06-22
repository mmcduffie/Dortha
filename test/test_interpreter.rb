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
		#@document.parse
		#lineCount = @document.lineCount
		#@interpreter.interpret(@document.tokenStore,lineCount)
		# TODO - No assertion here.
	end
	def test_currentClass
		test = @interpreter.currentClass.className
		assert_equal("class",test,"Base class should be named \"class\"")
	end
	def test_currentObject
		test = @interpreter.currentObject.objectName
		assert_equal("main",test,"Base object should be named \"main\"")
	end
	def test_call
		message = ["add 1 to"]
		receiver = NumberType.new(1)
		currentReceiverType = "Number"
		testResponce = @interpreter.call(message,receiver,currentReceiverType)
		assert_equal(receiver,testResponce,"The call method should always return the object it called.")
	end
	def test_callBuiltInMethod
		number = NumberType.new(1)
		test = @interpreter.callBuiltInMethod("add",[1],number)
		assert_equal(2,test,"One plus one equals two.")
	end
	def test_parseMethodArguments
		test = @interpreter.parseMethodArguments(/add .* to number .* with/,"add 11 to number 3 with")
		assert_equal([11,3],test,"This method should return the arguments of the method call.")
	end
	def test_parseMethodAncestors
		assert_raise(RuntimeError) do
			testMessages = ["bleh","wut"]
			notValid = @interpreter.parseMethodAncestors(testMessages)
		end
		testMessages = ["method","foo","of","bar","of","another","of"]
		chain = @interpreter.parseMethodAncestors(testMessages)
		assert_equal(["foo","bar","another"],chain,"The method's ancestor chain is not correct.")
	end
	def test_parseMessages
		testMessages = ["test1","bleh","otherstuff","and","test2","bleh","blah","and","test3"] # With and keywords.
		test = @interpreter.parseMessages(testMessages)
		assert_equal(["test1 bleh otherstuff","test2 bleh blah","test3"],test,"Method list not correct.")
		testMessages = ["test"] # With only one message.
		test = @interpreter.parseMessages(testMessages)
		assert_equal(["test"],test,"Method list not correct.")
		testMessages = ["test1 test2"] # With more than one message.
		test = @interpreter.parseMessages(testMessages)
		assert_equal(["test1 test2"],test,"Method list not correct.")
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
	def test_nestedMethodRecognition
		testArray = ["method test2 of test1 of bleh of whatever","test1 NextTest","anotherTest"]
		@document = Document.new(testArray)
		@interpreter = Interpreter.new
		@document.parse
		lineCount = @document.lineCount
		@interpreter.interpret(@document.tokenStore,lineCount)
		testMethod = @interpreter.currentClass.instanceMethods[0]
		testChain = testMethod.methodAncestors
		assert_equal(["test1","bleh","whatever"],testChain,"The method we created does not have a correct ancestor chain.")
	end
	def test_builtInMethodRecognition
		testArray = ["create variable number 1","add 1 to number"]
		@document = Document.new(testArray)
		@interpreter = Interpreter.new
		@document.parse
		lineCount = @document.lineCount
		@interpreter.interpret(@document.tokenStore,lineCount)
	end
end