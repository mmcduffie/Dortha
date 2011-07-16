require 'helper'

class NumberTest < Test::Unit::TestCase

  def setup
    @test = Dortha::Number.new(1,1)
  end
  
  def test_line_number
    @test.line_number = 1
    test = @test.line_number
    assert_equal test, 1
  end
  
  def test_bad_number
    assert_raise(ArgumentError) do
      notValid = @test = Dortha::Number.new("Foo")
    end
  end
end