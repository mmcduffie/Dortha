require 'helper'

class TokenTest < Test::Unit::TestCase

  def setup
    @token = Dortha::Token.new
  end
  
  def test_value
    @token.value = "foo"
    test = @token.value
    assert_equal "foo", test
  end
end