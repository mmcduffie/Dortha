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
		messages.each_with_index do |token,index|
			messages[index] = token.value
		end
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