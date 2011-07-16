require 'helper'

class ListTest < Test::Unit::TestCase

  def setup
    test_array = ["foo", "bar"]
    @list = Dortha::List.new(test_array,1)
  end
  
  def test_set_values
    @list.set_values("test1", "test2", "test3")
    assert_equal [nil,"test1", "test2", "test3"],@list.value,"List does not contain the data we expect."
  end
end