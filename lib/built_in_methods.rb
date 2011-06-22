module BuiltInMethods
	def add(args)
		addThis = args[0][0]
		toThis = args[1].value
		result = addThis + toThis
		args[1].value = result
	end
	def say(args)
		whatToSay = args[1]
		puts whatToSay.value
	end
end