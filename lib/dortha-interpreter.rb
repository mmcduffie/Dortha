class Interpreter
	def initialize
		loadEnviroment
		@currentClass = @class
		@currentMethod = nil
		@currentScope = @class # When code is executed outside of any user-defined class, it's scope is the base class.
	end
	def interpret(tokenStore,lineCount)
		@tokenStore = tokenStore
		@lineCount = lineCount
		lineCount.times do |line|
			currentReceiver = @tokenStore.receiver(line)
			currentMessages = @tokenStore.messages(line)
			keyword = currentMessages[0]
			if keyword == "class"
				@currentClass = Klass.new(currentReceiver)
				@currentScope = @currentClass
			elsif keyword == "method"
				if currentMessages.include?("of")
					chain = parseMethodAncestors(currentMessages)
					chain.push(currentReceiver)
					thisMethod = chain[0]
					chain.delete(thisMethod)
					@currentMethod = InstanceMethod.new(thisMethod,chain,@currentClass)
					@currentScope = @currentMethod
					@currentMethod.save
				else
					@currentMethod = InstanceMethod.new(currentReceiver,nil,@currentClass)
					@currentScope = @currentMethod
					@currentMethod.save
				end
			else
				if @currentScope.class == InstanceMethod
					currentLine = currentMessages
					currentLine.push(currentReceiver)
					@currentMethod.addLineToMethodBody(currentLine)
				elsif @currentScope.class == Klass
					messages = parseMessages(currentMessages)
					call(messages,currentReceiver)
				end
			end
		end
	end
	def currentClass
		@currentClass
	end
	def call(messages,receiver)
		until messages.empty?
			message = messages.pop
			@builtInMethodList.each_with_index do |method,index|
				if message.match(method)
					method = @builtInMethodNames[index]
					arguments = "" # TODO - need a method that can extract arguments from method call based on regexp?
					callBuiltInMethod(method,arguments,receiver)
				end
			end
		end
		return receiver
	end
	def callBuiltInMethod(method,arguments,receiver)
		# ToDo - need a built-in method for "add" and a way to call it based on sending the string "add" to this method.
	end
	def loadEnviroment
		@class = Klass.new("class") # Base class.
		@builtInMethodList = [/add .* to/,/subtract .* from/]
		@builtInMethodNames = ["add","subtract"]
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