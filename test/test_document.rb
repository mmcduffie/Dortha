require 'helper'

class DocumentTest < Test::Unit::TestCase
  
  def setup
    test_array = "  test1  		nextTest1\n test2 \"nextTest2\".\n test3 nextTest3."
    @document = Dortha::Document.new(test_array)
  end
  
  def test_raise
    assert_raise(Dortha::SyntaxError) do
      test_array = "  test1  		nextTest1\n test2 \"nextTest2\".\n test3 nextTest3"
      @document = Dortha::Document.new(test_array)
    end
  end
  
  def test_lex
    @document.lex
    test = []
    @document.each_with_index do |sentence,index|
      test[index] = sentence.map { |token| token.value }
    end
    assert_equal [["test1", "nextTest1", "test2", "nextTest2"], ["test3", "nextTest3"]], test
    test = []
    @document.each_with_index do |sentence,index|
      test[index] = sentence.map { |token| token.class }
    end
    assert_equal [[Dortha::Token, Dortha::Token, Dortha::Token, Dortha::String], [Dortha::Token, Dortha::Token]], test
  end
end