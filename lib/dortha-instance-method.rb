class InstanceMethod
	def initialize(methodName,klass)
		@methodName = methodName
	end
	def methodName
		@methodName
	end
	def methodRegexp(givenName)
		if givenName.include?("_")
			puts "REALLY?"
		else
			return givenName
		end
	end
end