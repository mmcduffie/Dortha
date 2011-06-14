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
			regexp = givenName.gsub(/_/,".*")
			#slash = "/"
			#regexp = regexp << "/"
			#regexp = slash << regexp
			return Regexp.new(regexp)
		else
			return givenName
		end
	end
end