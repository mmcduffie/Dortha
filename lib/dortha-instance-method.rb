# Instance methods are methods of a certian class. So, when creating one, the interpreter needs to
# first have an existing class to create one with. We supply the initializer for this class with
# a name for the method and a class like this: method = InstanceMethod.new(name_of_method,class_of_method)

class InstanceMethod
	def initialize(methodName,klass)
		@methodName = methodName
		@methodRegexp = makeMethodRegexp(methodName)
		@methodBody = []
		@class = klass
	end
	def klass
		@class
	end
	def methodName
		@methodName
	end
	def methodRegexp
		@methodRegexp
	end
	def makeMethodRegexp(givenName)
		if givenName.include?("_")
			regexp = givenName.gsub(/_/,".*")
			return Regexp.new(regexp)
		else
			return givenName
		end
	end
	def methodBody=(tokens)
		@methodBody = tokens
	end
	def methodBody
		@methodBody
	end
	def save
		@class.addInstanceMethod(self)
	end
end