require '../lib/interpreter_helper.rb'
require '../lib/dortha-interpreter.rb'
require 'test/unit'

class InterpreterHelperTest < Test::Unit::TestCase
	def setup
		@interpreter = Interpreter.new
	end
	def test_setObjectType
		#testToken = "\"String\""
		#test = @interpreter.setObjectType(testToken)
		#assert_equal("String",test)
		testToken = "1"
		test = @interpreter.setObjectType(testToken)
		assert_equal(1,test)
		testToken = "[1,2]"
		test = @interpreter.setObjectType(testToken)
		assert_equal([1,2],test)
		testToken = '[\"test1\",\"test2\"]'
		test = @interpreter.setObjectType(testToken)
		#assert_equal([1,2],test)
		testToken = "0"
		test = @interpreter.setObjectType(testToken)
		assert_equal(0,test)
		testToken = "Variable"
		@interpreter.setObjectType(testToken)
		klass = @interpreter.currentClass
		# Not sure what to do here. I don't really want this method to do anything
		# with variable names, so I guess there isn't much to test here...
		assert_raise(RuntimeError) do
			notValid = klass.showVariableValue(testToken)
		end
	end
end