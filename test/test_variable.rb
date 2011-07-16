require 'helper'

class VariableTest < Test::Unit::TestCase

  def setup
    @variable = Dortha::Variable.new
  end
  
  def test_value
    @variable.value = "foo"
    test = @variable.value
    assert_equal "foo", test
  end
end