class Interpreter
	def initialize
		loadEnviroment
		@currentClass = @class
		@currentMethod = nil
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
			end
			if keyword == "method"
				@currentMethod = InstanceMethod.new(currentReceiver,@currentClass)
				# Need to add the body of the method somehow.
				@currentMethod.save
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
end