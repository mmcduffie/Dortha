require 'helper'

class MockToken
  attr_accessor :value
end

class ProgramTest < Test::Unit::TestCase

  def setup
    document = [[nil],[]]
    @program = Dortha::Program.new(document)
  end
  
  def test_value?
    object1 = MockToken.new
    object1.value = "foo"
    object2 = MockToken.new
    object2.value = "bar"
    line = [object1,object2]
    # TODO - this test doesn't model how this class is actually going to be used.
  end
end