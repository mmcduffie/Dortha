module InterpreterHelper
	def createNew(value,type,messages) # The three types the parser can understand are "String", "Array", or "methodNameOrVariable".
		variableName = messages[1]
		if type == "methodNameOrVariable"
			# Not sure what to do here, probobly create a new instance of a class with this name?
			if value == "0"
				@currentObject.addInstanceVariable(variableName)
				@currentObject.assignValue(0,variableName)
			elsif value.to_i != 0
				number = value.to_i
				@currentObject.addInstanceVariable(variableName)
				@currentObject.assignValue(number,variableName)
			end
		elsif type == "String"
			@currentObject.addInstanceVariable(variableName)
			@currentObject.assignValue(value,variableName)
		elsif type == "Array"
			#puts "Array"
		end
		return @currentObject.getValue(variableName)
	end
	def convertObjectsByType(token)
		#if token.match(/^\"/) && token.match(/\"$/)
		#	return token
		#elsif token.match(/^\[/) && token.match(/\]$/)
		#	token.slice!(0)
		#	tokenLength = token.length
		#	nextToLast = tokenLength - 1
		#	token.slice!(nextToLast..tokenLength)
		#	array = token.split(",")
		#	array.each_with_index do |token,index|
		#		array[index] = setObjectType(token) # Each object in the array has to be passed through again.
		#	end
		#	return array
		if token == "0"
			return 0
		elsif token.to_i != 0
			return token.to_i
		end
		#	return token
		#end
	end
	def	parseMethodArguments(methodRegexp,methodCall)
		regexpString = methodRegexp.inspect
		regexpString.chop!
		regexpString = regexpString[1..regexpString.length] 
		mask = regexpString.split(/\.\*/)
		maskString = ""
		mask.each do |part|
			maskString << part
		end
		maskStringArray = maskString.split(//)
		methodCallArray = methodCall.split(//)
		methodCallArray.each_with_index do |char,index|
			if char != maskStringArray[index]
				maskStringArray.insert(index,"_")
			end
		end
		maskString = ""
		maskIndexes = []
		maskStringArray.each_with_index do |part,index|
			if part == "_"
				maskIndexes.push(index)
			end
			maskString << part
		end
		methodCall = ""
		methodCallArray.each do |part|
			methodCall << part
		end
		tempString = ""
		argumentArray = []
		more = false
		methodCallArray.each_with_index do |part,index|
			if maskIndexes.include?(index)
				tempString << part
				nextIndex = index + 1
				if maskStringArray[nextIndex] == "_"
					more = true
				else
					more = false
					argumentArray.push(tempString)
					tempString = ""
				end
			end
		end
		argumentArray.each_with_index do |token,index|
			argumentArray[index] = convertObjectsByType(token)
		end
		return argumentArray
	end
	def parseMethodAncestors(messages)
		if messages[0] == "method" && messages.include?("of")
			messages.delete("method")
			messages.delete("of")
			chain = messages
			return chain
		else
			raise "Method declaration not provided in the correct format"
		end
	end
	def parseMessages(messages)
		methodList = []
		until messages.empty?
			if messages.include?("and")
				endOfString = messages.index("and")
				tempArray = messages[0..endOfString]
				tempArray.pop
				tempString = ""
				tempArray.each do |string|
					tempString << string << " "
				end
				tempString.chop! # The loop above leaves one trailing space.
				methodList.push(tempString)
				messages.slice!(0..endOfString)
			else
				tempString = ""
				messages.each do |string|
					tempString << string << " "
				end
				tempString.chop!
				methodList.push(tempString)
				messages.slice!(0..messages.length) 
			end
		end
		return methodList
	end
end