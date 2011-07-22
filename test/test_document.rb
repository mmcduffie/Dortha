require 'helper'

class DocumentTest < Test::Unit::TestCase
  
  def setup
    test_array = "  test1 nexttTest1.\ntest2 \"nextTest2\".\ntest3 nextTest3."
    @document = Dortha::Document.new(test_array)
  end
  
  def test_lex
    @document.lex
  end
end