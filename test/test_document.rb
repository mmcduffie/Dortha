require 'helper'

class DocumentTest < Test::Unit::TestCase
  
  def setup
    test_array = [nil,"  test1 nexttTest1","test2 \"nextTest2\"","test3 nextTest3"] # Notice leading spaces. Also notice first element is nil.
    @document = Dortha::Document.new(test_array)
  end
  
  def test_without_nil
    test_array = ["test1"]
    @document = Dortha::Document.new(test_array)
    assert_equal @document, [nil, "test1"], "When no leading nil is present, it should be inserted."
  end
  
  def test_lex
    test_array = []
    @document.lex
    @document.each_with_index do |line,index|
      unless line[0].nil?
        test_array[index] = line[0].value
      end
    end
    test_array.shift
    assert_equal ["test1", "test2", "test3"], test_array, "the lexed document is not what we expected."
  end
  
  def test_add_token
    @document = Dortha::Document.new([[nil],[]])
    def @document.proxy_add_token(*args)
      add_token(*args)
    end
    @document.proxy_add_token("test",1)
    test = @document[1][0]
    assert_equal "test", test.value, "Token value not correct."
  end
  
  def test_strip_single_token
    test_line = [[nil],['Token']]
    @document = Dortha::Document.new(test_line)
    def @document.proxy_strip_single_token(*args)
      strip_single_token(*args)
    end
    test = @document.proxy_strip_single_token(1)
    assert_equal "Token", @document[1][1].value, "Token string on line should be replaced with a Token object."
  end
  
  def test_strip_plain_token
    test_line = [[nil],['Token  AnotherToken']] # Notice there are two spaces in the middle of this line.
    @document = Dortha::Document.new(test_line)
    def @document.proxy_strip_plain_token(*args)
      strip_plain_token(*args)
    end
    test = @document.proxy_strip_plain_token(1)
    assert_equal "Token", @document[1][1].value, "Token string on line should be replaced with a Token object."
  end
  
  def test_strip_quoted_token
    test_line = [[nil],['"Quoted Token"  non-quoted-token']]
    @document = Dortha::Document.new(test_line)
    def @document.proxy_strip_quoted_token(*args)
      strip_quoted_token(*args)
    end
    test = @document.proxy_strip_quoted_token(1)
    assert_equal "Quoted Token", @document[1][1].value, "Token object not what we expected."
    assert_equal Dortha::String, @document[1][1].class, "Token should be of class Dortha::String."
  end
end