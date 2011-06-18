module BuiltInMethods
	def add(args)
		addThisArray = args[0]
		addThis = addThisArray[0]
		addThis = addThis.to_i
		toThis = args[1].to_i
		result = addThis + toThis
	end
	def say(args)
		whatToSay = args[1]
		if whatToSay.match(/^\"/) && whatToSay.match(/\"$/)
			theEnd = whatToSay.length - 2
			whatToSay = whatToSay[1..theEnd]
		end
		puts whatToSay
	end
end