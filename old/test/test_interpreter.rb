require '../lib/dortha-interpreter.rb'
require '../lib/dortha-document.rb'
require '../lib/types/dortha-number-type.rb'
require 'test/unit'

class InterpreterTest < Test::Unit::TestCase
	def setup # Provided document should be an array representing lines from the source file, with newlines removed.
		testArray = ["test1 middleMethod nexttTest1","test2 \"nextTest2\"","test3 [nextTest3]"] # Notice multiple methods per line.
		@document = Document.new(testArray)
		@interpreter = Interpreter.new
	end
	
	# These tests are for methods that monkey-patch the Ruby Array class.
	
	def test_stringify
		token1 = DorthaStringType.new("test1",1)
		token2 = DorthaStringType.new("test2",1)
		token3 = DorthaStringType.new("test3",1)
		testArray = [token1,token2,token3]
		testResult = testArray.stringify
		assert_equal(["test1","test2","test3"],testResult,"returned array not correct.")
	end
	def test_includesValue?
		token1 = DorthaStringType.new("test1",1)
		token2 = DorthaStringType.new("test2",1)
		token3 = DorthaStringType.new("test3",1)
		testArray = [token1,token2,token3]
		test = testArray.includesValue?("test2")
		assert_equal(true,test,"includesValue? should return true if object of given value is found in target array.")
		test = testArray.includesValue?("foo")
		assert_equal(false,test,"includesValue? should return false if object of given value is not found.")
	end
	
	def test_interpret
		@document.parse
		@interpreter.interpret(@document.tokenStore)
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
		token1 = DorthaOtherType.new("add",1)
		token2 = DorthaNumberType.new("1",1)
		token3 = DorthaOtherType.new("to",1)
		message = [[token1,token2,token3]]
		receiver = DorthaNumberType.new(1,1)
		testResponce = @interpreter.call(message,receiver)
		assert_equal(receiver,testResponce,"The call method should always return the object it called.")
		# TODO - More assertions? Like test calling a built-in method from here?
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
		@interpreter = Interpreter.new
		assert_raise(RuntimeError) do
			object1 = DorthaStringType.new("bleh",1)
			object2 = DorthaStringType.new("wut",1)
			testMessages = [object1,object2]
			notValid = @interpreter.parseMethodAncestors(testMessages)
		end
		object1 = DorthaStringType.new("method",1)
		object2 = DorthaStringType.new("foo",1)
		object3 = DorthaStringType.new("of",1)
		object4 = DorthaStringType.new("bar",1)
		object5 = DorthaStringType.new("of",1)
		object6 = DorthaStringType.new("another",1)
		object7 = DorthaStringType.new("of",1)
		testMessages = [object1,object2,object3,object4,object5,object6,object7]
		chain = @interpreter.parseMethodAncestors(testMessages)
		testChain = chain.stringify
		assert_equal(["foo","bar","another"],testChain,"The method's ancestor chain is not correct.")
	end
	def test_withClassKeyword
		klass = DorthaKeywordType.new("class",1)
		testClass = DorthaStringType.new("testClass",1)
		testArray = [klass,testClass]
		@document = Document.new(testArray)
		@interpreter = Interpreter.new
		@interpreter.interpret(@document.tokenStore)
		test = @interpreter.currentClass.className
		assert_equal("class",test,"The class we created should have the name we expect.")
	end
	def test_withMethodKeyword
		testArray = ["method \"TestMethod\"","test1 NextTest","anotherTest"]
		@document = Document.new(testArray)
		@interpreter = Interpreter.new
		@document.parse
		@interpreter.interpret(@document.tokenStore)
		testMethod = @interpreter.currentClass.instanceMethods[0]
		test = testMethod.methodName
		assert_equal("TestMethod",test,"The method we created should have the name we expect.")
		test = testMethod.methodBody
		# TODO - For some reason, if I have two lines, we only get the firdt one out. If we have
		# one line, we get nothing.
		testLine = []
		test.each do |line|
			line.each do |object|
				testLine.push(object.value)
			end
		end
		assert_equal(["test1","NextTest"],testLine,"The method we created should have the content we expect.")
	end
	def test_nestedMethodRecognition
		testArray = ["method \"test2\" of \"test1\" of \"bleh\" of \"whatever\"","test1 NextTest","anotherTest"]
		@document = Document.new(testArray)
		@interpreter = Interpreter.new
		@document.parse
		@interpreter.interpret(@document.tokenStore)
		testMethod = @interpreter.currentClass.instanceMethods[0]
		testChain = testMethod.methodAncestors.stringify
		assert_equal(["test1","bleh","whatever"],testChain,"The method we created does not have a correct ancestor chain.")
	end
	def test_builtInMethodRecognition
		testArray = ["create variable number 1","add 1 to number"]
		@document = Document.new(testArray)
		@interpreter = Interpreter.new
		@document.parse
		@interpreter.interpret(@document.tokenStore)
		# TODO - How do I test this?
	end
end