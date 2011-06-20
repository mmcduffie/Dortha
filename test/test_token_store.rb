require '../lib/dortha-token-store.rb'
require 'test/unit'

class TokenStoreTest < Test::Unit::TestCase
	def setup
		@store = TokenStore.new
	end
	def test_addToken
		@store.addToken("test1",3,"String")
		@store.addToken("test2",3,"String")
		testArray = @store.tokenStore
		testLine = testArray[3]
		testToken = testLine[0]
		assert_equal("test1",testToken,"Token not what we expected.")
		testToken = testLine[1]
		assert_equal("test2",testToken,"Token not what we expected.")
	end
	def test_addTokenToNewLine
		@store.addTokenToNewLine("test1",3,"String")
		testArray = @store.tokenStore
		testLine = testArray[3]
		assert_not_nil(testLine,"Line array not created")
		testToken = testLine[0]
		assert_equal("test1",testToken,"Token not what we expected.")
	end
	def test_addTokenToExistingLine
		@store.addTokenToNewLine("test1",3,"String")
		@store.addTokenToExistingLine("test2",3,"String")
		testArray = @store.tokenStore
		testLine = testArray[3]
		testToken = testLine[1] # Notice this is the second token on line 3.
		assert_equal("test2",testToken,"Token not what we expected.")
	end
	def test_receiver
		@store.addToken("test1",3,"String")
		@store.addToken("test2",3,"String")
		assert_raise(RuntimeError) do
			notValid = @store.receiver(1)
		end
		receiver = @store.receiver(3)
		assert_equal("test2",receiver,"Receiver not what we expected.")
	end
	def test_receiverType
		@store.addToken("test1",3,"String")
		@store.addToken("test2",3,"String")
		assert_raise(RuntimeError) do
			notValid = @store.receiverType(1)
		end
		receiverType = @store.receiverType(3)
		assert_equal("String",receiverType,"Receiver type not what we expected.")
	end
	def test_messages
		@store.addToken("test1",3,"String")
		@store.addToken("test2",3,"String")
		@store.addToken("test3",3,"String")
		messages = @store.messages(3)
		assert_equal(["test1","test2"],messages,"Messages not what we expected.")
	end
end