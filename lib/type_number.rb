# Central to the philosophy of Dortha is simplicity of the language over 
# speed or effecient memory use. That is why we have only one class of 
# numbers. No matter how large or small, numbers will always be of this
# basic type.

class NumberType
	def initialize(value)
		@value = value
	end
	def objectType
		"number"
	end
	def value
		@value
	end
	def value=(value)
		@value = value
	end
end