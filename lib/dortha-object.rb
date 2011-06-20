# Creating a class called "Object" here would add methods and properties
# to Ruby's built-in Object class, which would be a lazy way to implement
# an object model (since I could just use Ruby's), but I want to write my
# own, so I'm going to internally call Object "Thing", but in the language
# Docs and syntax it will be "Object"

class Thing
	def initialize(name)
		@instanceVariables = []
		@instanceVariableValues = []
		@klass = nil
		@objectName = name
	end
	def objectName
		@objectName
	end
	def addInstanceVariable(variable)
		if @instanceVariables.include?(variable)
			return
		else
			@instanceVariables.push(variable)
		end
	end
	def InstanceVariables
		@instanceVariables
	end
	def assignValue(value,variable)
		index = 0
		if @instanceVariables.index(variable)
			index = @instanceVariables.index(variable)
		else
			raise "The instance variable you are attempting to assign a value to does not exist."
		end
		@instanceVariableValues[index] = value
	end
	def getValue(variable)
		index = 0
		if @instanceVariables.index(variable)
			index = @instanceVariables.index(variable)
		else
			raise "Variable not found."
		end
		@instanceVariableValues[index]
	end
	def klass=(klass) # We call the object's class "klass" so it doesn't trip over Ruby's built-in "class". 
		@klass = klass
	end
	def klass
		@klass
	end
end