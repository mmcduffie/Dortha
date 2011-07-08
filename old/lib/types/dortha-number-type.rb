require '../lib/types/dortha-base-type.rb'

class DorthaNumberType < DorthaBaseType
	def initialize(value,lineNumber)
		if Float(value)
			@value = value.to_i
		end
		@lineNumber = lineNumber
	end
	def number?
		true
	end
end