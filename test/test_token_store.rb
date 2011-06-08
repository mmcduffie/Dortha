require '../lib/dortha-token-store.rb'
require 'test/unit'

class TokenStoreTest < Test::Unit::TestCase
	def setup
		@store = TokenStore.new
	end
	def test_addToken
		@store.addToken("test1",3)
		@store.addToken("test2",3)
		testArray = @store.tokenStore
		testLine = testArray[3]
		testToken = testLine[0]
		assert_equal("test1",testToken,"Token not what we expected.")
		testToken = testLine[1]
		assert_equal("test2",testToken,"Token not what we expected.")
	end
	def test_addTokenToNewLine
		@store.addTokenToNewLine("test1",3)
		testArray = @store.tokenStore
		testLine = testArray[3]
		assert_not_nil(testLine,"Line array not created")
		testToken = testLine[0]
		assert_equal("test1",testToken,"Token not what we expected.")
	end
	def test_addTokenToExistingLine
		@store.addTokenToNewLine("test1",3)
		@store.addTokenToExistingLine("test2",3)
		testArray = @store.tokenStore
		testLine = testArray[3]
		testToken = testLine[1] # Notice this is the second token on line 3.
		assert_equal("test2",testToken,"Token not what we expected.")
	end
end