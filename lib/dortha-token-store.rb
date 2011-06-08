class TokenStore
	def initialize
		@tokenStore = []
	end
	def tokenStore
		@tokenStore
	end
	def addToken(value,line)
		if @tokenStore[line]
			addTokenToExistingLine(value,line)
		else
			addTokenToNewLine(value,line)
		end
	end
	def addTokenToNewLine(value,line)
		lineArray = []
		lineArray[0] = value
		@tokenStore[line] = lineArray
	end
	def addTokenToExistingLine(value,line)
		lineArray = @tokenStore[line]
		lineArray.push(value)
	end
end