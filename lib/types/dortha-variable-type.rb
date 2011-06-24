require '../lib/types/dortha-base-type.rb'

# The variable type is used by the interpreter to identify tokens
# that are variables. Usually, a variable is a token that isn't a
# string, number, array, or keyword and is the last token on a line.

class DorthaVariableType < DorthaBaseType
	def initialize(value,lineNumber)
		@value = value
		@lineNumber = lineNumber
	end
	def variable?
		true
	end
end