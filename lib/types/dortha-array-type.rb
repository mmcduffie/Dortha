require '../lib/types/dortha-base-type.rb'

class DorthaArrayType < DorthaBaseType
	def initialize(value)
		@value = value
	end
	def array?
		true
	end
end