require 'helper'

class DocumentTest < Test::Unit::TestCase
  def setup
    testArray = [nil,"  test1 nexttTest1","test2 \"nextTest2\"","test3 [nextTest3]"] # Notice leading spaces. Also notice first element is nil.
	@document = Dortha::Document.new(testArray)
  end
end