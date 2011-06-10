class Interpreter
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
end