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
					message = messages[0]
					call(message,currentReceiver)
				end
			end
		end
	end
	def currentClass
		@currentClass
	end
	def call(messages,receiver)
		puts "#{messages.inspect} #{receiver}"
		# TODO - Gotta get method calling for built-in methods locked down.
		return receiver
	end
	def loadEnviroment
		@class = Klass.new("class") # Base class.
		@output = Klass.new("output") # Built-in output class.
		@output.superClass = "class"
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