require 'helper'

class MockToken
  attr_accessor :value
end

class LineTest < Test::Unit::TestCase

  def test_value?
    object1 = MockToken.new
    object1.value = "foo"
    object2 = MockToken.new
    object2.value = "bar"
    line = Dortha::Line.new([object1,object2])
    assert_equal true,line.contains_value?("foo")
    assert_equal false,line.contains_value?("bleh")
  end
end