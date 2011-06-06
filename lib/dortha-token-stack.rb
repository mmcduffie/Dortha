class TokenStack
	def initialize
		@lineNumbers = []
		@tokens = []
		@reciever = []
	end
	def inspect
		totalTokens = @tokens.length
		output = ""
		totalTokens.times do |index|
			output << "Token: #{@tokens[index]} Line: #{@lineNumbers[index]} Receiver: #{@reciever[index]}"
			if index != totalTokens - 1
				output << ", "
			end
		end
		output
	end
	def lineCount=(lineCount)
		@lineCount = lineCount
	end
	def lineCount
		@lineCount
	end
	def lineNumbers
		@lineNumbers
	end
	def tokens
		@tokens
	end
	def markToken # markToken marks whatever the last token is as being a reciever.
		@reciever[@reciever.length - 1] = true
	end
	def pushToken(lineNumber,token)
		@lineNumbers.push(lineNumber)
		@tokens.push(token)
		@reciever.push(false)
	end
	def popToken
		lastLineNumber = @lineNumbers.pop
		lastToken = @tokens.pop
		lastReceiver = @reciever.pop
		if (lastLineNumber && lastToken && lastReceiver).nil?
			return nil
		else
			token = Hash["lineNumber" => lastLineNumber, "value" => lastToken, "receiver" => lastReceiver]
		end
	end
end