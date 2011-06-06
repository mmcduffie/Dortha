class Interpreter
	def interpret(tokenStack)
		firstToken = tokenStack.popToken
		reciever = firstToken["value"]
		lineNumber = firstToken["lineNumber"]
	end
end