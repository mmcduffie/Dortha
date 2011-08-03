require 'helper'

class MethodTest < Test::Unit::TestCase
  def test_create_method
    object1 = mock
    object1.stubs(:value).returns("create")
    object2 = mock
    object2.stubs(:value).returns("method")
    sentence = Dortha::Sentence.new([object1,object2,Dortha::String.new("foo")])
    program = mock
    program.stubs(:scope).returns(:global)
    program.stubs(:global_method_list).returns(Hash.new)
    program.stubs(:scope=)
    sentence.interpret(program)
  end
end