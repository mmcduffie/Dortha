require 'helper'

class DocumentTest < Test::Unit::TestCase
  def setup
    test_array = [nil,"  test1 nexttTest1","test2 \"nextTest2\"","test3 nextTest3"] # Notice leading spaces. Also notice first element is nil.
    @document = Dortha::Document.new(test_array)
  end
  def test_lex
    before_test = @document
    @document.lex
    # TODO - need to create String class and make quoted strings create String objects.
  end
  def test_convert_lines_to_arrays
    def @document.fake_convert_lines_to_arrays
      convert_lines_to_arrays
    end
    @document.fake_convert_lines_to_arrays
    assert_equal [[nil],["  test1 nexttTest1"],["test2 \"nextTest2\""],["test3 nextTest3"]], @document
  end
  def test_add_token
    @document = Dortha::Document.new([[nil],[]])
    def @document.fake_add_token(*args)
      add_token(*args)
    end
    @document.fake_add_token("test",1)
    test = @document[1][0]
    assert_equal "test", test.value, "Token value not correct."
  end
  def test_strip_single_token
    test_line = [[nil],['Token']]
    @document = Dortha::Document.new(test_line)
    def @document.fake_strip_single_token(*args)
      strip_single_token(*args)
    end
    test = @document.fake_strip_single_token(1)
    assert_equal "Token", @document[1][1].value, "Token string on line should be replaced with a Token object."
  end
  def test_strip_plain_token
    test_line = [[nil],['Token  AnotherToken']] # Notice there are two spaces in the middle of this line.
    @document = Dortha::Document.new(test_line)
    def @document.fake_strip_plain_token(*args)
      strip_plain_token(*args)
    end
    test = @document.fake_strip_plain_token(1)
    assert_equal "Token", @document[1][1].value, "Token string on line should be replaced with a Token object."
  end
  def test_strip_quoted_token
    test_line = [[nil],['"Quoted Token"  non-quoted-token']]
    @document = Dortha::Document.new(test_line)
    def @document.fake_strip_quoted_token(*args)
      strip_quoted_token(*args)
    end
    test = @document.fake_strip_quoted_token(1)
    assert_equal "Quoted Token", @document[1][1].value, "Token object not what we expected."
  end
end