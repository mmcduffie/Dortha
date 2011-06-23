class DorthaStringType < DorthaBaseType
	def initialize(value)
		@value = value
	end
	def string?
		true
	end
end