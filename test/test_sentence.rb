require 'helper'

class SentenceTest < Test::Unit::TestCase

  def setup
    object1 = mock
    object1.stubs(:value).returns("create")
    object2 = mock
    object2.stubs(:value).returns("variable")
    @sentence = Dortha::Sentence.new([object1, object2])
  end

  def test_interpret
    object = mock
    object.stubs(:scope).returns(:global)
    @sentence.interpret(object)
  end
 
  def test_value?
    object1 = mock
    object1.stubs(:value).returns("foo")
    object2 = mock
    object2.stubs(:value).returns("bar")
    sentence = Dortha::Sentence.new([object1,object2])
    assert_equal true, sentence.contains_value?("foo")
    assert_equal false, sentence.contains_value?("bleh")
  end
  
  def test_detect_number_types
    object1 = mock
    object1.stubs(:value).returns("1")
    object2 = mock
    object2.stubs(:value).returns("0")
    object3 = mock
    object3.stubs(:value).returns("foo")
    sentence = Dortha::Sentence.new([object1,object2,object3])
    sentence.detect_number_types
    assert_equal Dortha::Number, sentence[0].class, "First object should be of class 'Number'."
    assert_equal Dortha::Number, sentence[1].class, "Second object should be of class 'Number', even though it was a zero."
    assert_equal Mocha::Mock, sentence[2].class, "Last object should be unchanged."
  end
  
  def test_detect_keywords
    object1 = mock
    object1.stubs(:value).returns("create")
    object2 = mock
    object2.stubs(:value).returns("foo")
    sentence = Dortha::Sentence.new([object1,object2])
    sentence.detect_keywords
    assert_equal Dortha::Keyword, sentence[0].class, "Objects created should be of class 'Keyword'."
    assert_equal Mocha::Mock, sentence[1].class, "Others should be ignored."
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
    test = {"foo"=>5.0}
    assert_equal test, sentence.current_program.global_variable_list, "This sentence should set the variable's value."
  end
end