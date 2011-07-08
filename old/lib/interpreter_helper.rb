require '../lib/type_number.rb'
require '../lib/type_string.rb'

module InterpreterHelper
	def createNew(receiver,type,messages) # The three types the parser can understand are "String", "Array", or "methodNameOrVariable".
		object = nil
		typeToCreate = messages[1]
		if typeToCreate == "variable"
			variableName = messages[2]
			if type == "methodNameOrVariable"
				if receiver == "0"
					object = NumberType.new(0)
					@currentObject.addInstanceVariable(variableName)
					@currentObject.assignValue(object,variableName)
				elsif receiver.to_i != 0
					number = receiver.to_i
					object = NumberType.new(number)
					@currentObject.addInstanceVariable(variableName)
					@currentObject.assignValue(object,variableName)
				end
			elsif type == "String"
				object = StringType.new(receiver)
				@currentObject.addInstanceVariable(variableName)
				@currentObject.assignValue(object,variableName)
			elsif type == "Array"
				# TODO - Add code for creating array objects from strings that look like arrays.
			end
			return object
		end
	end
	def convertObjectsByType(token)
		if token == "0"
			return 0
		elsif token.to_i != 0
			return token.to_i
		end
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
			argumentArray[index] = convertObjectsByType(token) # String of different data types are converted to objects at this point.
		end
		return argumentArray
	end
	def parseMethodAncestors(messages)
		chain = []
		ofKeywordPresent = false
		messages.each do |message|
			value = message.value
			if value == "of"
				ofKeywordPresent = true
			end
		end
		if messages[0].value == "method" && ofKeywordPresent == true
			messages.each do |object|
				unless object.value == "method" || object.value == "of"
					chain.push(object)
				end
			end
		else
			raise "Method declaration not provided in the correct format"
		end
		return chain
	end
	def parseMessages(messages)
		methodList = []
		until messages.empty?
			if firstAndIndex = messages.index { |token| token.value == "and" && token.keyword? }
				if firstAndIndex == 0
					raise "The and keyword cannot be the first thing on a line."
				end
				tempArray = messages.take(firstAndIndex) # Take is not zero-indexed.
				methodList.push(tempArray.clone) # Have to clone here our clear will delete the array.
				tempArray.clear
				messages = messages.drop(firstAndIndex + 1)
			else
				methodList.push(messages.clone)
				messages.clear
			end
		end
		return methodList
	end
end