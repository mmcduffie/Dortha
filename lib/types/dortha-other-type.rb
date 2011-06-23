require '../lib/types/dortha-base-type.rb'

# The other type is used by the interpreter to identify tokens that are not
# keywords, strings, numbers, arrays, or variables. These are going to mostly
# be parts of method declarations or calls, modifiers, and other things.

class DorthaOtherType < DorthaBaseType
	def initialize(value)
		@value = value
	end
	def other?
		true
	end
end