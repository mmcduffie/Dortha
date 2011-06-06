class Interpreter
	def interpret(tokenStack)
		stepOneTokenStack = []
		index = 0
		loop do # Read token stack into memory.
			stepOneTokenStack.push(tokenStack.popToken) # Pull one off the top of the stack.
			break if stepOneTokenStack[index] == nil # We've reached the bottom of the stack.
			index += 1
		end
		stepOneTokenStack.pop # Last one is always nil. 
	end
end