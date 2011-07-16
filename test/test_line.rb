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
    assert_equal true, line.contains_value?("foo")
    assert_equal false, line.contains_value?("bleh")
  end
  
  def test_detect_number_types
    object1 = MockToken.new
    object1.value = "1"
    object2 = MockToken.new
    object2.value = "0"
	object3 = MockToken.new
    object3.value = "foo"
    line = Dortha::Line.new([object1,object2,object3])
    line.detect_number_types
	assert_equal Dortha::Number, line[0].class, "First object should be of class 'Number'."
	assert_equal Dortha::Number, line[1].class, "Second object should be of class 'Number', even though it was a zero."
	assert_equal MockToken, line[2].class, "Last object should be unchanged."
  end
end