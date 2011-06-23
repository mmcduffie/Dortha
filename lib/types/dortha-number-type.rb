class DorthaNumberType < DorthaBaseType
	def initialize(value)
		@value = value
	end
	def number?
		true
	end
end