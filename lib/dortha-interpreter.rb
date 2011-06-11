class Interpreter
	def initialize
		loadEnviroment
	end
	def interpret(tokenStore,lineCount)
		@tokenStore = tokenStore
		@lineCount = lineCount
		lineCount.times do |line|
			currentReceiver = @tokenStore.receiver(line)
			currentMessages = @tokenStore.messages(line)
		end
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