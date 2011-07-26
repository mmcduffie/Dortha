require 'helper'

class MockToken
  attr_accessor :value
end

class SentenceTest < Test::Unit::TestCase

  def setup
    @sentence = Dortha::Sentence.new([Dortha::Keyword.new("create"), Dortha::Keyword.new("variable")])
  end

  def test_interpret
    @sentence.interpret
  end
 
  def test_value?
    object1 = MockToken.new
    object1.value = "foo"
    object2 = MockToken.new
    object2.value = "bar"
    sentence = Dortha::Sentence.new([object1,object2])
    assert_equal true, sentence.contains_value?("foo")
    assert_equal false, sentence.contains_value?("bleh")
  end
  
  def test_detect_number_types
    object1 = MockToken.new
    object1.value = "1"
    object2 = MockToken.new
    object2.value = "0"
    object3 = MockToken.new
    object3.value = "foo"
    sentence = Dortha::Sentence.new([object1,object2,object3])
    sentence.detect_number_types
    assert_equal Dortha::Number, sentence[0].class, "First object should be of class 'Number'."
    assert_equal Dortha::Number, sentence[1].class, "Second object should be of class 'Number', even though it was a zero."
    assert_equal MockToken, sentence[2].class, "Last object should be unchanged."
  end
  
  def test_detect_keywords
    object1 = MockToken.new
    object1.value = "create"
    object2 = MockToken.new
    object2.value = "foo"
    sentence = Dortha::Sentence.new([object1,object2])
    sentence.detect_keywords
    assert_equal Dortha::Keyword, sentence[0].class, "Objects created should be of class 'Keyword'."
    assert_equal MockToken, sentence[1].class, "Others should be ignored."
  end
  
  def test_create?
    random_object = MockToken.new
	random_object.value = "foo"
    sentence = Dortha::Sentence.new([Dortha::Keyword.new("create"),random_object])
	test = sentence.create?
	assert_equal true, test, "If first word in sentence is 'create' then the sentence creates somthing."
  end
end