require 'helper'

class DocumentTest < Test::Unit::TestCase
  def setup
    testArray = [nil,"  test1 nexttTest1","test2 \"nextTest2\"","test3 [nextTest3]"] # Notice leading spaces. Also notice first element is nil.
	@document = Dortha::Document.new(testArray)
  end
  def test_strip_single_token
    test_line = [nil,'Token']
	@document = Dortha::Document.new(test_line)
	@document.strip_single_token(1) # This method expects a line number. We'll give it one.
  end
end