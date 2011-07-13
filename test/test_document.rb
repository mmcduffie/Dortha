require 'helper'

class DocumentTest < Test::Unit::TestCase
  def setup
    testArray = [nil,"  test1 nexttTest1","test2 \"nextTest2\"","test3 [nextTest3]"] # Notice leading spaces. Also notice first element is nil.
	@document = Dortha::Document.new(testArray)
  end
  def test_strip_single_token
    test_line = [nil,'Token']
	@document = Dortha::Document.new(test_line)
	test = @document.strip_single_token(1) # This method expects a line number. We'll give it one.
	assert_equal "Token", @document[1][0].value, "Token string on line should be replaced with a Token object."
  end
end