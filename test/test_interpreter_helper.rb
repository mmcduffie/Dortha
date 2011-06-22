require '../lib/interpreter_helper.rb'
require '../lib/dortha-interpreter.rb'
require 'test/unit'

class InterpreterHelperTest < Test::Unit::TestCase
	def setup
		@interpreter = Interpreter.new
	end
	def test_createNew
		value = "1"
		type = "methodNameOrVariable"
		messages = ["create","variable","TestNumber","with","value"]
		testObject = @interpreter.createNew(value,type,messages)
		test = testObject.value
		assert_equal(1,test,"Our new variable should have it's value stored in the current object.")
		value = "some text"
		type = "String"
		messages = ["create","variable","textVariable","with","value"]
		thing = @interpreter.createNew(value,type,messages)
		test = @interpreter.currentObject.klass
		assert_equal("class",test,"Our new variable is stored in the current object, and the current object's class should be \"class\".")
		test = @interpreter.currentObject.getValue("textVariable")
		assert_equal("some text",test,"Our new variable should have it's value stored in the current object.")
	end
	def test_convertObjectsByType
		
		# TODO - finish this test. Need to figure out the details of new object creation before we
		# can worry about what to do with objects we already have.
	
		#testToken = "test string"
		#testTokenType = "String"
		#test = @interpreter.convertObjectsByType(testToken,testTokenType)
		#assert_equal("test string",test)
		#testToken = "1"
		#test = @interpreter.convertObjectsByType(testToken)
		#assert_equal(1,test)
		#testToken = "[1,2]"
		#test = @interpreter.convertObjectsByType(testToken)
		#assert_equal([1,2],test)
		#testToken = '[\"test1\",\"test2\"]'
		#test = @interpreter.convertObjectsByType(testToken)
		#assert_equal([1,2],test)
		#testToken = "0"
		#test = @interpreter.convertObjectsByType(testToken)
		#assert_equal(0,test)
		#testToken = "Variable"
		#@interpreter.convertObjectsByType(testToken)
		#klass = @interpreter.currentClass
		# Not sure what to do here. I don't really want this method to do anything
		# with variable names, so I guess there isn't much to test here...
		#assert_raise(RuntimeError) do
		#	notValid = klass.showVariableValue(testToken)
		#end
	end
end