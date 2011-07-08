require '../lib/dortha-instance-method.rb'
require 'test/unit'

class InstanceMethodTest < Test::Unit::TestCase
	def setup
		@klass = Klass.new("test")
		object = DorthaStringType.new("foo",1)
		@method = InstanceMethod.new(object,nil,@klass)
	end
	def test_klass
		@testClass = @method.klass
		test = @testClass.className
		assert_equal("test",test,"This is not the class we're looking for.")
	end
	def test_methodAncestors
		@klass = Klass.new("test")
		chain = ["a","chain","with","methods"]
		object = DorthaStringType.new("foo",1)
		@method = InstanceMethod.new(object,chain,@klass)
		test = @method.methodAncestors
		assert_equal(["a","chain","with","methods"],test,"Ancestor chain not what we set it to.")
	end
	def test_methodName
		test = @method.methodName
		assert_equal("foo",test,"Name of method not what we set it to.")
		assert_raise(RuntimeError) do
			object = DorthaNumberType.new(1,1)
			badMethod = InstanceMethod.new(object,nil,@klass)
		end
	end
	def test_methodRegexp
		object = DorthaStringType.new("this _ a _",1)
		@method = InstanceMethod.new(object,nil,"test")
		test = @method.methodRegexp
		assert_equal(/this .* a .*/,test,"Returned regexp not what we expected.")
	end
	def test_makeMethodRegexp
		object = DorthaStringType.new("foo",1)
		test = @method.makeMethodRegexp(object)
		assert_equal("foo",test,"When method name has no underscores, this should return what it recived.")
		object = DorthaStringType.new("add _ to",1)
		test = @method.makeMethodRegexp(object)
		assert_equal(/add .* to/,test,"This call should return a regexp object of the expected format.")
		object = DorthaStringType.new(" _ my face _ with",1)
		test = @method.makeMethodRegexp(object)
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