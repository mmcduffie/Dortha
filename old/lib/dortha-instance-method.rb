# Instance methods are methods of a certian class. So, when creating one, the interpreter needs to
# first have an existing class to create one with. We supply the initializer for this class with
# a name for the method and a class like this: method = InstanceMethod.new(name_of_method,class_of_method)

class InstanceMethod
	def initialize(methodName,ancestors,klass)
		unless methodName.string?
			raise "Method name must be a string! Method names must be enclosed in quotes."
		end
		@methodName = methodName.value
		@methodRegexp = makeMethodRegexp(methodName)
		@methodBody = []
		@methodAncestors = ancestors
		@class = klass
	end
	def klass
		@class
	end
	def methodAncestors
		@methodAncestors
	end
	def methodName
		@methodName
	end
	def methodRegexp
		@methodRegexp
	end
	def makeMethodRegexp(givenName)
		givenName = givenName.value
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
	def addLineToMethodBody(line)
		@methodBody.push(line)
	end
	def save
		@class.addInstanceMethod(self)
	end
end