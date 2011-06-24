require '../lib/types/dortha-number-type.rb'

module DocumentHelper
	# convertTokenToObject takes tokens and turns tokens into objects of
	# the types 'keyword', 'number', or 'other.' The lexer creates objects
	# of the types 'string' and 'array', since it is already using quotes and
	# brakets to pull apart sentances anyways. Tokens of type 'variable' will
	# have to be created in the interpreter.
	def convertTokenToObject(inputString,lineNumber)
		object = nil
		keywords = ["class","create","method"]
		if keywords.index(inputString) # keyword
			object = DorthaKeywordType.new(inputString)
			object.lineNumber = lineNumber
			return object
		elsif inputString == "0"  # number
			object = DorthaNumberType.new(0)
			object.lineNumber = lineNumber
			return object
		elsif inputString.to_i != 0  # number
			object = DorthaNumberType.new(inputString.to_i)
			object.lineNumber = lineNumber
			return object
		else  # other
			object = DorthaOtherType.new(inputString)
			object.lineNumber = lineNumber
			return object
		end
	end
end