require '../lib/document_helper.rb'
require '../lib/types/dortha-array-type.rb'
require '../lib/types/dortha-keyword-type.rb'
require '../lib/types/dortha-number-type.rb'
require '../lib/types/dortha-string-type.rb'
require '../lib/types/dortha-other-type.rb'
require '../lib/types/dortha-variable-type.rb'

class Document < Array
	include DocumentHelper
	def initialize(sourceFile)
		super # Call ruby's built-in Array initializer.
		@tokenStore = TokenStore.new
		@lineCount = 0
	end
	def tokenStore
		@tokenStore
	end
	def lineCount
		@lineCount
	end
	def parse
		self.each_with_index do |line,lineNumber|
			line.lstrip! # Strip leading whitespace on each line.
			until line.empty?
				if line.match(/^\"/) # If line starts with a quote...
					stripQuotedToken(lineNumber)
				elsif line.match(/^\[/) # If line starts with a bracket...
					stripBraketedToken(lineNumber)
				elsif line.match(/\s/) # If line contains whitespace...
					stripPlainToken(lineNumber)
				else # If nothing else, it's probobly a line with only one token. In that case, just take it off the line.
					stripSingleToken(lineNumber)
				end
			end
			@lineCount += 1
		end
	end
	def stripSingleToken(lineNumber)
		tokenLength = self[lineNumber].length # Find end of Token.
		tokenString = self[lineNumber].slice!(0,tokenLength) # Remove token from line.
		token = convertTokenToObject(tokenString,lineNumber + 1)
		@tokenStore.addToken(token)
	end
	def stripPlainToken(lineNumber)
		tokenLength = self[lineNumber].index(/\s/) # Find end of Token (indicated by whitespace).
		if tokenLength.nil?
			raise "Token is not followed by whitespace! Please use stripSingleToken instead. Line was this: #{self.inspect}"
		end
		tokenString = self[lineNumber].slice!(0,tokenLength) # Remove token from line.
		while self[lineNumber].match(/^\s/) # If characters after token are whitespace...
			self[lineNumber].slice!(0) # Delete them.
		end
		token = convertTokenToObject(tokenString,lineNumber + 1)
		@tokenStore.addToken(token)
	end
	def stripQuotedToken(lineNumber)
		self[lineNumber].slice!(0) # Remove leading quote.
		endingQuote = self[lineNumber].index(/\"/) # Find next quote.
		tokenString = self[lineNumber].slice!(0,endingQuote + 1) # Remove quoted token from line.
		while self[lineNumber].match(/^\s/) # If characters after quoted token are whitespace...
			self[lineNumber].slice!(0) # Delete them.
		end
		tokenStringLength = tokenString.length
		tokenStringNextToLast = tokenStringLength - 1
		tokenString.slice!(tokenStringNextToLast..tokenStringLength) #We Don't want a quote on the end of the string for storage.
		token = DorthaStringType.new(tokenString,lineNumber + 1)
		@tokenStore.addToken(token)
	end
	def stripBraketedToken(lineNumber)
		self[lineNumber].slice!(0) # Remove leading braket.
		endingBraket = self[lineNumber].index(/\]/) # Find next braket.
		tokenString = self[lineNumber].slice!(0,endingBraket + 1) # Remove braketed token from line.
		while self[lineNumber].match(/^\s/) # If characters after braketed token are whitespace...
			self[lineNumber].slice!(0) # Delete them.
		end
		tokenString = '[' + tokenString # Put a braket back on the front of the string for storage.
		token = DorthaArrayType.new(tokenString,lineNumber + 1)
		@tokenStore.addToken(token)
	end
end