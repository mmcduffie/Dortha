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
	def test_parseMessages
		token1 = DorthaOtherType.new("test1",1)
		token2 = DorthaOtherType.new("bleh",1)
		token3 = DorthaOtherType.new("otherstuff",1)
		token4 = DorthaKeywordType.new("and",1)
		token5 = DorthaOtherType.new("test2",1)
		token6 = DorthaOtherType.new("bleh",1)
		token7 = DorthaOtherType.new("blah",1)
		token8 = DorthaKeywordType.new("and",1)
		token9 = DorthaOtherType.new("test3",1)
		testMessages = [token1,token2,token3,token4,token5,token6,token7,token8,token9] # With and keywords.
		test = @interpreter.parseMessages(testMessages)
		assert_equal(["test1 bleh otherstuff","test2 bleh blah","test3"],test,"Method list not correct.")
		testMessages = [token1] # With only one message.
		test = @interpreter.parseMessages(testMessages)
		assert_equal(["test1"],test,"Method list not correct.")
	end
end