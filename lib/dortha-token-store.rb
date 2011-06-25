class TokenStore
	def initialize
		@tokenStore = []
		@tokenTypes = []
	end
	def tokenStore
		@tokenStore
	end
	def lineCount
		count = @tokenStore.length
		if count == 0
			return 0
		elsif count > 0
			return count - 1
		end
	end
	def addToken(token)
		line = token.lineNumber
		if @tokenStore[line]
			addTokenToExistingLine(token)
		else
			addTokenToNewLine(token)
		end
	end
	def addTokenToNewLine(token)
		line = token.lineNumber
		lineArray = []
		lineArray[0] = token
		@tokenStore[line] = lineArray
	end
	def addTokenToExistingLine(token)
		line = token.lineNumber
		lineArray = @tokenStore[line]
		lineArray.push(token)
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