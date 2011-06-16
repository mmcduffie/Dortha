require '../lib/dortha-instance-method.rb'
require 'test/unit'

class InstanceMethodTest < Test::Unit::TestCase
	def setup
		@klass = Klass.new("test")
		@method = InstanceMethod.new("foo",@klass)
	end
	def test_klass
		@testClass = @method.klass
		test = @testClass.className
		assert_equal("test",test,"This is not the class we're looking for.")
	end
	def test_methodName
		test = @method.methodName
		assert_equal("foo",test,"Name of function not what we set it to.")
	end
	def test_methodRegexp
		@method = InstanceMethod.new("this _ a _","test")
		test = @method.methodRegexp
		assert_equal(/this .* a .*/,test,"Returned regexp not what we expected.")
	end
	def test_makeMethodRegexp
		test = @method.makeMethodRegexp("foo")
		assert_equal("foo",test,"When method name has no underscores, this should return what it recived.")
		test = @method.makeMethodRegexp("add _ to")
		assert_equal(/add .* to/,test,"This call should return a regexp object of the expected format.")
		test = @method.makeMethodRegexp(" _ my face _ with")
		assert_equal(/ .* my face .* with/,test,"This call should return a regexp object of the expected format.")
	end
	def test_methodBody
		@method.methodBody = [["test1","middleMethod","nextTest1"],["test2","\"nextTest2\""],["test3","[nextTest3]"]]
		test = @method.methodBody
		assert_equal([["test1","middleMethod","nextTest1"],["test2","\"nextTest2\""],["test3","[nextTest3]"]],test)
	end
	def test_addLineToMethodBody
		@method.addLineToMethodBody(["test1","nextTest1"])
		test = @method.methodBody
		assert_equal([["test1","nextTest1"]],test,"Line not added to method like we expected.")
	end
	def test_save
		@method.methodBody = [["test1","middleMethod","nexttTest1"],["test2","\"nextTest2\""],["test3","[nextTest3]"]]
		@method.save
		test = @klass.instanceMethods[0]
		assert_equal(@method,test,"The method object we saved does not match the one we are accessing.")
	end
end