class DorthaBaseType
	def initialize
		@value = nil
	end
	def number?
		false
	end
	def string?
		false
	end
	def array?
		false
	end
	def keyword?
		false
	end
	def variable?
		false
	end
	def value=(value)
		@value = value
	end
	def value
		@value
	end
end