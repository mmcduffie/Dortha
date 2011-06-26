require '../lib/interpreter_helper.rb'
require '../lib/dortha-object.rb'
require '../lib/built_in_methods.rb'

class Interpreter
	include InterpreterHelper
	include BuiltInMethods
	def initialize
		@instance = Klass.new("class") # Base class.
		@currentObject = Thing.new("main") # Base object
		@currentObject.klass = "class"
		@builtInMethodList = [/add .* to/,/subtract .* from/,/say/]
		@builtInMethodNames = ["add","subtract","say"]
		@currentClass = @instance
		@currentMethod = nil
		@currentScope = @instance # When code is executed outside of any user-defined class, it's scope is the base class.
	end
	def currentClass
		@currentClass
	end
	def currentObject
		@currentObject
	end
	def interpret(tokenStore)
		@tokenStore = tokenStore
		@tokenStore.convertOthersToVariables # It's awkward, but we have to call this here since the lexer doesn't mark variables.
		lineCount = @tokenStore.lineCount
		lineCount.times do |line|
			unless line == 0 # We ignore line zero because it's confusing. The lexer also doesn't put anything here.
				currentReceiver = @tokenStore.receiver(line)
				currentReceiverType = currentReceiver.class # Notice we also get the object's type here.
				currentMessages = @tokenStore.messages(line)
				keyword = currentMessages[0] # For keyword detection.
				if keyword == "class"
					@currentClass = Klass.new(currentReceiver)
					@currentScope = @currentClass
				elsif keyword == "create"
					createNew(currentReceiver,currentReceiverType,currentMessages)
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
	end
	def call(messages,receiver)
		if receiver.other?
			#receiver = @currentObject.getValue(receiver.value)
			
			# TODO - need to check for existing variables. We probobly need the
			# interpreter to convert tokens into the 'variable' type first.
		end
		until messages.empty?
			message = messages.pop
			@builtInMethodList.each_with_index do |method,index|
				if message.match(method)
					methodName = @builtInMethodNames[index]
					arguments = parseMethodArguments(method,message)
					callBuiltInMethod(methodName,arguments,receiver)
				end
			end
		end
		return receiver
	end
	def callBuiltInMethod(method,arguments,receiver)
		args = []
		args.push(arguments)
		args.push(receiver)
		self.send(method,args)
	end
end