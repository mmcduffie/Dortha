class TokenStack
	def initialize
		@lineNumbers = []
		@tokens = []
	end
	def inspect
		totalTokens = @tokens.length
		output = ""
		totalTokens.times do |index|
			output << "Token: #{@tokens[index]} Line: #{@lineNumbers[index]}"
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
	def pushToken(lineNumber,token)
		@lineNumbers.push(lineNumber)
		@tokens.push(token)
	end
	def popToken
		lastLineNumber = @lineNumbers.pop
		lastToken = @tokens.pop
		token = Hash["lineNumber" => lastLineNumber, "value" => lastToken]
	end
end