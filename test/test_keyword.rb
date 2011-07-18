require 'helper'

class KeywordTest < Test::Unit::TestCase

  def test_bad_keyword
    assert_raise(RuntimeError) do
      notValid = Dortha::Keyword.new("foo")
    end
  end
end