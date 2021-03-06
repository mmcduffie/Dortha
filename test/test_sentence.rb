require 'helper'

class SentenceTest < Test::Unit::TestCase

  def setup
    object1 = mock
    object1.stubs(:value).returns("create")
    object2 = mock
    object2.stubs(:value).returns("variable")
    object3 = mock
    object3.stubs(:value).returns("x")
    @sentence = Dortha::Sentence.new([object1, object2, object3])
  end

  def test_interpret
    program = mock
    program.stubs(:scope).returns(:global)
    program.stubs(:global_variable_list).returns(Hash.new)
    @sentence.interpret(program)
    assert_raise(Dortha::SyntaxError) do
      object1 = mock
      object1.stubs(:value).returns("create")
      object2 = mock
      object2.stubs(:value).returns("foo")
      @sentence = Dortha::Sentence.new([object1, object2])
      @sentence.interpret(program)
    end
  end
  
  def test_create_objects
    object1 = mock
    object1.stubs(:value).returns("create")
    object2 = mock
    object2.stubs(:value).returns("variable")
    sentence = Dortha::Sentence.new([object1,object2,Dortha::String.new("foo")])
    program = mock
    program.stubs(:scope).returns(:global)
    program.stubs(:global_variable_list).returns(Hash.new)
    sentence.interpret(program)
    test = {"foo"=>nil}
    assert_equal test, sentence.current_program.global_variable_list, "This sentence should create a new variable."
    object1 = mock
    object1.stubs(:value).returns("set")
    object2 = mock
    object2.stubs(:value).returns("equal")
    object3 = mock
    object3.stubs(:value).returns("to")
    object4 = mock
    object4.stubs(:value).returns("5")
    sentence = Dortha::Sentence.new([object1,Dortha::String.new("foo"),object2,object3,object4])
    sentence.interpret(program)
    assert_equal 5.0, sentence.current_program.global_variable_list["foo"].value, "This sentence should set the variable's value."
  end
  
  def test_non_keyword
    object1 = mock
    object1.stubs(:value).returns("create")
    object2 = mock
    object2.stubs(:value).returns("variable")
    sentence = Dortha::Sentence.new([object1,object2,Dortha::String.new("foo")])
    program = mock
    program.stubs(:scope).returns(:global)
    program.stubs(:global_variable_list).returns(Hash.new)
    sentence.interpret(program)
    object1 = mock
    object1.stubs(:value).returns("set")
    object2 = mock
    object2.stubs(:value).returns("foo")
    object3 = mock
    object3.stubs(:value).returns("equal")
    object4 = mock
    object4.stubs(:value).returns("to")
    sentence = Dortha::Sentence.new([object1,object2,object3,object4,Dortha::Number.new(10)])
    sentence.interpret(program)
    object1 = mock
    object1.stubs(:value).returns("add")
    object2 = mock
    object2.stubs(:value).returns("5")
    object3 = mock
    object3.stubs(:value).returns("to")
    object4 = mock
    object4.stubs(:value).returns("foo")
    object4.stubs(:find_sentence_signature).returns(:foo)
    object4.stubs(:find_sentence_signature_regexp).returns(/add \w+ to/)
    object4.stubs(:foo).returns("foo")
    sentence = Dortha::Sentence.new([object1,object2,object3,object4])
    sentence.interpret(program)
  end
end