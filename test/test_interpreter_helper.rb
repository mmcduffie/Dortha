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
		test = @interpreter.currentObject.getValue("textVariable").value # Strings are objects, have to refer to their value.
		assert_equal("some text",test,"Our new variable should have it's value stored in the current object.")
	end
end