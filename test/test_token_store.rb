require '../lib/dortha-token-store.rb'
require 'test/unit'

class TokenStoreTest < Test::Unit::TestCase
	def setup
		@store = TokenStore.new
	end
	def test_lineCount
		test = @store.lineCount # No lines yet.
		assert_equal(0,test,"Line count should be 0.") 
		token = DorthaStringType.new("test1",1)
		@store.addToken(token)
		token = DorthaStringType.new("test2",1) # Notice this is also on line 1.
		@store.addToken(token)
		test = @store.lineCount
		assert_equal(1,test,"Line count should be 1.")
		token = DorthaStringType.new("test3",2) # Now we add another token on another line.
		@store.addToken(token)
		test = @store.lineCount
		assert_equal(2,test,"Line count should be 2.")
	end
	def test_addToken
		token = DorthaStringType.new("test1",3)
		@store.addToken(token)
		token = DorthaStringType.new("test2",3)
		@store.addToken(token)
		testArray = @store.tokenStore
		testLine = testArray[3]
		testToken = testLine[0]
		assert_equal("test1",testToken.value,"Token not what we expected.")
		testToken = testLine[1]
		assert_equal("test2",testToken.value,"Token not what we expected.")
	end
	def test_addTokenToNewLine
		token = DorthaStringType.new("test1",3)
		@store.addTokenToNewLine(token)
		testArray = @store.tokenStore
		testLine = testArray[3]
		assert_not_nil(testLine,"Line array not created")
		testToken = testLine[0]
		assert_equal("test1",testToken.value,"Token not what we expected.")
	end
	def test_addTokenToExistingLine
		token = DorthaStringType.new("test1",3)
		@store.addTokenToNewLine(token)
		token = DorthaStringType.new("test2",3)
		@store.addTokenToExistingLine(token)
		testArray = @store.tokenStore
		testLine = testArray[3]
		testToken = testLine[1] # Notice this is the second token on line 3.
		assert_equal("test2",testToken.value,"Token not what we expected.")
	end
	def test_receiver
		token1 = DorthaStringType.new("test1",3)
		token2 = DorthaStringType.new("test2",3)
		@store.addToken(token1)
		@store.addToken(token2)
		assert_raise(RuntimeError) do
			notValid = @store.receiver(1)
		end
		receiver = @store.receiver(3)
		assert_equal(token2,receiver,"Receiver not what we expected.")
	end
	def test_messages
		token1 = DorthaStringType.new("test1",3)
		token2 = DorthaStringType.new("test2",3)
		token3 = DorthaStringType.new("test3",3)
		@store.addToken(token1)
		@store.addToken(token2)
		@store.addToken(token3)
		messages = @store.messages(3)
		assert_equal([token1,token2],messages,"Messages not what we expected.")
	end
	def test_convertOthersToVariables
		token1 = DorthaStringType.new("test1",1)
		token2 = DorthaOtherType.new("variable",1)
		@store.addToken(token1)
		@store.addToken(token2)
		@store.convertOthersToVariables
		test = @store.tokenStore[1][1] # The second token on the first line.
		assert_equal(true,test.variable?,"token should be of type variable")
	end
end