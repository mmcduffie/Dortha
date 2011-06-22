require '../lib/built_in_methods.rb'
require '../lib/dortha-interpreter.rb'
require 'test/unit'

class BuiltInMethodsTest < Test::Unit::TestCase
	def setup
		@interpreter = Interpreter.new
	end
	def test_add
		theNumberOne = NumberType.new(1)
		test = @interpreter.add([[1],theNumberOne])
		assert_equal(2,test,"One plus one is two.")
	end
	def test_say
		# TODO - Finish this test.
	end
end