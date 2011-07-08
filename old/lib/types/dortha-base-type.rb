# The main reason for a base type class is so that we
# can ask objects of any of the language's types if they
# are a particular type of object or not. This saves us
# alot of complication in the interpreter.

class DorthaBaseType
	def initialize
		@value = nil
		@name = nil
		@lineNumber = nil
	end
	def number?
		false
	end
	def string?
		false
	end
	def array?
		false
	end
	def keyword?
		false
	end
	def variable?
		false
	end
	def other?
		false
	end
	def value=(value)
		@value = value
	end
	def value
		@value
	end
	def name=(name)
		@name = name
	end
	def name
		@name
	end
	def lineNumber=(lineNumber)
		@lineNumber = lineNumber
	end
	def lineNumber
		@lineNumber
	end
end