require 'helper'

class NumberTest < Test::Unit::TestCase

  def setup
    @test = Dortha::Number.new(1)
  end
  
  def test_bad_number
    assert_raise(ArgumentError) do
      notValid = Dortha::Number.new("Foo")
    end
  end
end