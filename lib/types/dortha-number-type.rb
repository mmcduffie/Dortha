require '../lib/types/dortha-base-type.rb'

class DorthaNumberType < DorthaBaseType
	def initialize(value)
		@value = value
	end
	def number?
		true
	end
end