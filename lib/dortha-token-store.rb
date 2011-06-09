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
	def messages(line)
		lineArray = @tokenStore[line]
		temp = lineArray.clone
		temp.pop
		temp
	end
end