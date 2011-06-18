require '../lib/interpreter_helper.rb'
require '../lib/dortha-interpreter.rb'
require 'test/unit'

class InterpreterHelperTest < Test::Unit::TestCase
	def setup
		@interpreter = Interpreter.new
	end
	def test_detectObjectType
		testToken = "\"String\""
		test = @interpreter.detectObjectType(testToken)
		assert_equal("String",test)
		testToken = "1"
		test = @interpreter.detectObjectType(testToken)
		assert_equal("Number",test)
		testToken = "[array]"
		test = @interpreter.detectObjectType(testToken)
		assert_equal("Array",test)
		testToken = "0"
		test = @interpreter.detectObjectType(testToken)
		assert_equal("Number",test)
		testToken = "Variable"
		test = @interpreter.detectObjectType(testToken)
		assert_equal("Variable",test)
	end
end