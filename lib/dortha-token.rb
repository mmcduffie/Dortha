class Token
	def initialize(tokenStack,tokenStore)
		@tokenStack = tokenStack
		@tokenStore = tokenStore
	end
	def lineNumber=(lineNumber)
		@lineNumber = lineNumber
	end
	def lineNumber
		@lineNumber
	end
	def value=(value)
		@value = value
	end
	def value
		@value
	end
	def save
		@tokenStack.pushToken(@lineNumber,@value)
		@tokenStore.addToken(@value,@lineNumber)
	end
end