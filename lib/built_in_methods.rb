module BuiltInMethods
	def add(args)
		addThisArray = args[0]
		addThis = addThisArray[0]
		toThis = args[1]
		result = addThis + toThis
	end
	def say(args)
		whatToSay = args[1]
		puts whatToSay
	end
end