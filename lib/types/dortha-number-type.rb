require '../lib/types/dortha-base-type.rb'

class DorthaNumberType < DorthaBaseType
	def initialize(value,lineNumber)
		@value = value
		@lineNumber = lineNumber
	end
	def number?
		true
	end
end