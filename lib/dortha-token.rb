class Token
	def initialize(tokenStore)
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
	def objectType=(objectType)
		@objectType = objectType
	end
	def objectType
		@objectType
	end
	def save
		@tokenStore.addToken(@value)
	end
end