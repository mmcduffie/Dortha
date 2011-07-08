require '../lib/types/dortha-base-type.rb'

class DorthaArrayType < DorthaBaseType
	def initialize(value,lineNumber)
		@value = value
		@lineNumber = lineNumber
	end
	def array?
		true
	end
end