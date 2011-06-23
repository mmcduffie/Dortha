require '../lib/types/dortha-base-type.rb'

# The keyword type is used by the interpreter to identify tokens that are keywords 
# in the language. Often, the first token on a line is a keyword. However, to become
# a keyword, the first token on the line has to match a list of built-in keywords.

class DorthaKeywordType < DorthaBaseType
	def initialize(value)
		@value = value
	end
	def keyword?
		true
	end
end