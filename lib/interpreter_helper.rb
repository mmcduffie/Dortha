module InterpreterHelper
	def setObjectType(token)
		if token.match(/^\"/) && token.match(/\"$/)
			#return token
		elsif token.match(/^\[/) && token.match(/\]$/)
			token.slice!(0)
			tokenLength = token.length
			nextToLast = tokenLength - 1
			token.slice!(nextToLast..tokenLength)
			array = token.split(",")
			array.each_with_index do |token,index|
				array[index] = setObjectType(token) # Each object in the array has to be passed through again.
			end
			return array
		elsif token == "0"
			return 0
		elsif token.to_i != 0
			return token.to_i
		else
			return # Anything else should be a variable name.
		end
	end
end