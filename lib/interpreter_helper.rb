module InterpreterHelper
	def detectObjectType(token)
		if token.match(/^\"/) && token.match(/\"$/)
			return "String"
		elsif token.match(/^\[/) && token.match(/\]$/)
			return "Array"
		elsif token == "0"
			return "Number"
		elsif token.to_i != 0
			return "Number"
		else
			return "Variable"
		end
	end
end