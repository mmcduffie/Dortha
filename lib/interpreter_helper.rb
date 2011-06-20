module InterpreterHelper
	def createNew(value,type,messages) # The three types the parser can understand are "String", "Array", or "methodNameOrVariable".
		variableName = messages[1]
		if type == "methodNameOrVariable"
			# Not sure what to do here, probobly create a new instance of a class with this name?
		elsif type == "String"
			thing = Thing.new
			thing.objectName = variableName
		elsif type == "Array"
			#puts "Array"
		end
	end
	def convertObjectsByType(token,tokenType)
		if token.match(/^\"/) && token.match(/\"$/)
			return token
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
			return token
		end
	end
end