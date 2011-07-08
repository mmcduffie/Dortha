require '../lib/types/dortha-base-type.rb'

class DorthaStringType < DorthaBaseType
	def initialize(value,lineNumber)
		@value = value
		@lineNumber = lineNumber
	end
	def string?
		true
	end
end