# We call this class "Klass" so it won't step on the toes of Ruby's built in "Class"
# This will only be called Klass in this internal implementation. In the laguage docs
# and syntax, it will be called "class".

class Klass
	def initialize
		@superClass = nil
		@classMethods = []
	end
	def superClass
		@superClass
	end
	def superClass=(superClass)
		@superClass = superClass
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