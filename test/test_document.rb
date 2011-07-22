require 'helper'

class DocumentTest < Test::Unit::TestCase
  
  def setup
    test_array = "  test1 nexttTest1.\ntest2 \"nextTest2\".\ntest3 nextTest3."
    @document = Dortha::Document.new(test_array)
  end
  
  def test_lex
    @document.lex
    test = @document.each { |array| array.map! {|object| object.value } }
    assert_equal [["test1", "nexttTest1"],["test2", "nextTest2"],["test3", "nextTest3"]], test, "the lexed document is not what we expected."
  end
  
  def test_object_creation
    @document.lex
    test = @document.each { |array| array.map! {|object| object.class } }
    assert_equal [[Dortha::Token, Dortha::Token],[Dortha::Token, Dortha::String],[Dortha::Token, Dortha::Token]], test, "the lexed document is not what we expected."
  end
  
  def test_build_sentences
    test_array = "test1 test2 test3.\ntest4 test5\ntest6 test7\ntest8 test9\ntest10 test11."
    @document = Dortha::Document.new(test_array)
    @document.lex
    test = @document.each { |array| array.map! {|object| object.value } }
    assert_equal [["test1", "test2", "test3"],["test4", "test5", "test6", "test7", "test8", "test9", "test10", "test11"]], test
  end
  
  def test_check_for_ending_period
    test_array = ["test1","test2"]
    @document = Dortha::Document.new(test_array)
    assert_raise(RuntimeError) do
      notValid = @document.lex
    end
  end
end