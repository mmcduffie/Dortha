require 'helper'

class KeywordTest < Test::Unit::TestCase

  def test_bad_keyword
    assert_raise(Dortha::InternalError) do
      notValid = Dortha::Keyword.new("foo")
    end
  end
end