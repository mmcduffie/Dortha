require 'helper'

class DocumentTest < Test::Unit::TestCase
  
  def setup
    test_array = ["  test1 nexttTest1.","test2 \"nextTest2\".","test3 nextTest3."]
    @document = Dortha::Document.new(test_array)
  end
  
  def test_lex
    test_array = []
    @document.lex
    @document.each_with_index do |line,index|
      test_array[index] = line[0].value
    end
    assert_equal ["test1", "test2", "test3"], test_array, "the lexed document is not what we expected."
  end
  
  def test_build_sentences
    test_array = ["test1 test2 test3.","test4 test5","test6 test7","test8 test9","test10 test11."]
    @document = Dortha::Document.new(test_array)
    @document.lex
    test = @document.each { |array| array.map! {|object| object.value } }
    assert_equal [["test1", "test2", "test3."],["test4", "test5", "test6", "test7", "test8", "test9", "test10", "test11."]], test
  end
  
  def test_check_for_ending_period
    test_array = ["test1","test2"]
    @document = Dortha::Document.new(test_array)
    assert_raise(RuntimeError) do
      notValid = @document.lex
    end
  end
  
  def test_all_lines_have_periods?
    test_array = ["test1.","test2."]
    @document = Dortha::Document.new(test_array)
    def @document.proxy_all_lines_have_periods?
      all_lines_have_periods?
    end
    test = @document.proxy_all_lines_have_periods?
    assert_equal true, test, "When all lines have periods, this should return true."
    test_array = ["test1","test2."]
    @document = Dortha::Document.new(test_array)
    def @document.proxy_all_lines_have_periods?
      all_lines_have_periods?
    end
    test = @document.proxy_all_lines_have_periods?
    assert_equal false, test, "When all lines don't have periods, this should return false."
  end
  
  def test_add_token
    @document = Dortha::Document.new([[]])
    def @document.proxy_add_token(*args)
      add_token(*args)
    end
    @document.proxy_add_token("test",0)
    test = @document[0][0]
    assert_equal "test", test.value, "Token value not correct."
  end
  
  def test_strip_single_token
    test_line = [['Token']]
    @document = Dortha::Document.new(test_line)
    def @document.proxy_strip_single_token(*args)
      strip_single_token(*args)
    end
    test = @document.proxy_strip_single_token(0)
    assert_equal "Token", @document[0][1].value, "Token string on line should be replaced with a Token object."
  end
  
  def test_strip_plain_token
    test_line = [['Token  AnotherToken']] # Notice there are two spaces in the middle of this line.
    @document = Dortha::Document.new(test_line)
    def @document.proxy_strip_plain_token(*args)
      strip_plain_token(*args)
    end
    test = @document.proxy_strip_plain_token(0)
    assert_equal "Token", @document[0][1].value, "Token string on line should be replaced with a Token object."
  end
  
  def test_strip_quoted_token
    test_line = [['"Quoted Token"  non-quoted-token']]
    @document = Dortha::Document.new(test_line)
    def @document.proxy_strip_quoted_token(*args)
      strip_quoted_token(*args)
    end
    test = @document.proxy_strip_quoted_token(0)
    assert_equal "Quoted Token", @document[0][1].value, "Token object not what we expected."
    assert_equal Dortha::String, @document[0][1].class, "Token should be of class Dortha::String."
  end
end