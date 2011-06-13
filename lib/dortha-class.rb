# We call this class "Klass" so it won't step on the toes of Ruby's built in "Class"
# This will only be called Klass in this internal implementation. In the laguage docs
# and syntax, it will be called "class".

class Klass
	def initialize(name)
		@name = name
		@superClass = nil
		@classMethods = []
		@instaceMethods = []
	end
	def superClass
		@superClass
	end
	def superClass=(superClass)
		@superClass = superClass
	end
	def addInstanceMethod(method)
		@instaceMethods.push(method)
	end
	def instanceMethods
		@instaceMethods
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
end