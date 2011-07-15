require 'helper'

class StringTest < Test::Unit::TestCase
  def setup
    @test = Dortha::String.new("test",1)
  end
  def test_line_number
    @test.line_number = 1
	test = @test.line_number
	assert_equal test, 1
  end
end