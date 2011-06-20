class TokenStore
	def initialize
		@tokenStore = []
		@tokenTypes = []
	end
	def tokenStore
		@tokenStore
	end
	def addToken(value,line,objectType)
		if @tokenStore[line]
			addTokenToExistingLine(value,line,objectType)
		else
			addTokenToNewLine(value,line,objectType)
		end
	end
	def addTokenToNewLine(value,line,objectType)
		lineArray = []
		lineArray[0] = value
		@tokenStore[line] = lineArray
		typeArray = []
		typeArray[0] = objectType
		@tokenTypes[line] = typeArray
	end
	def addTokenToExistingLine(value,line,objectType)
		lineArray = @tokenStore[line]
		lineArray.push(value)
		typeArray = @tokenTypes[line]
		typeArray.push(objectType)
	end
	def receiver(line)
		receiver = nil
		if @tokenStore[line]
			lineArray = @tokenStore[line]
			receiver = lineArray [lineArray.length - 1]
		else
			raise "The line provided does not exist."
		end
		return receiver
	end
	def receiverType(line)
		receiverType = nil
		if @tokenTypes[line]
			lineArray = @tokenTypes[line]
			receiverType = lineArray [lineArray.length - 1]
		else
			raise "The line provided does not exist."
		end
		return receiverType
	end
	def messages(line)
		lineArray = @tokenStore[line]
		temp = lineArray.clone
		temp.pop
		temp
	end
end