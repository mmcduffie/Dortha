require '../lib/types/dortha-base-type.rb'

class DorthaStringType < DorthaBaseType
	def initialize(value)
		@value = value
	end
	def string?
		true
	end
end