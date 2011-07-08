# We call this class "Klass" so it won't step on the toes of Ruby's built in "Class"
# This will only be called Klass in this internal implementation. In the laguage docs
# and syntax, it will be called "class".

class Klass
	def initialize(name)
		@name = name
		@superClass = nil
		@classMethods = []
		@instanceMethods = []
		@instanceVariables = []
		@instanceVariableValues = []
	end
	def className
		@name
	end
	def superClass
		@superClass
	end
	def superClass=(superClass)
		@superClass = superClass
	end
	def addInstanceMethod(method)
		@instanceMethods.push(method)
	end
	def instanceMethods
		@instanceMethods
	end
	def addClassMethod(method)
		@classMethods.push(method)
	end
	def classMethods
		@classMethods
	end
	def checkForMethod(method)
		if @classMethods.index(method)
			return true
		else
			return false
		end
	end
	def addInstanceVariable(name,value)
		@instanceVariables.push(name)
		@instanceVariableValues.push(value)
	end
	def showVariableValue(name)
		index = @instanceVariables.index(name)
		if index.nil?
			raise "No variable found by the name \"#{name}\"."
		end
		value = @instanceVariableValues[index]
	end
end