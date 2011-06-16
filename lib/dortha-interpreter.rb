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
				currentLine = currentMessages
				currentLine.push(currentReceiver)
				if @currentScope.class == InstanceMethod
					@currentMethod.addLineToMethodBody(currentLine)
				end
			end
		end
	end
	def currentClass
		@currentClass
	end
	def call(message,receiver)
		receiver ||= Module.const_get(receiver)
		receiver.send(message)
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
end