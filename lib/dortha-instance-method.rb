class InstanceMethod
	def initialize(methodName,klass)
		@methodName = methodName
		@class = klass
	end
	def methodName
		@methodName
	end
	def methodRegexp(givenName)
		if givenName.include?("_")
			#puts givenName.match(/add.*to/)
			puts givenName.match(/.*my face.*with/)
		else
			return givenName
		end
	end
end