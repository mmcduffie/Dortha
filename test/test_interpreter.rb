require '../lib/dortha-interpreter.rb'
require 'test/unit'

class InterpreterTest < Test::Unit::TestCase
	def test_interpret
		@tokenStack = TokenStack.new
		@tokenStack.pushToken(1,"foo")
		@tokenStack.pushToken(2,"bar")
		@interpreter = Interpreter.new
		@interpreter.interpret(@tokenStack)
	end
end