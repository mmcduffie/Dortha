require '../lib/dortha-token.rb'
require '../lib/dortha-token-store.rb'
require 'test/unit'

class TokenTest < Test::Unit::TestCase
	def setup
		@store = TokenStore.new
		@token = Token.new(@store)
	end
	def test_lineNumber
		@token.lineNumber = 1
		assert_equal(1,@token.lineNumber,"Token line number is incorrect.")
	end
	def test_value
		@token.value = "foo"
		assert_equal("foo",@token.value,"Token value is incorrect.")
	end
	def test_objectType
		@token.objectType = "String"
		assert_equal("String",@token.objectType,"Token type is incorrect.")
	end
	def test_name
		@token.name = "test"
		assert_equal("test",@token.name,"Token name is incorrect.")
	end
end