require '../lib/dortha-class.rb'
require 'test/unit'

class KlassTest < Test::Unit::TestCase
	def setup
		@klass = Klass.new("klass")
	end
	def test_className
		test = @klass.className
		assert_equal("klass",test,"Class name not what we expected.")
	end
	def test_superClass
		@klass.superClass = "foo"
		test = @klass.superClass
		assert_equal("foo",test,"Class should be what we set it to.")
	end
	def test_addInstanceMethod
		@klass.addInstanceMethod("foo")
		test = @klass.instanceMethods[0]
		assert_equal("foo",test,"Class should have method we added to it.")
	end
	def test_addClassMethod
		@klass.addClassMethod("foo")
		test = @klass.classMethods[0]
		assert_equal("foo",test,"Class should have method we added to it.")
	end
	def test_checkForMethod
		@klass.addClassMethod("foo")
		assert(@klass.checkForMethod("foo"),"checkForMethod should return true.")
	end
	def test_showVariableValue
		@klass.addInstanceVariable("foo",1)
		test = @klass.showVariableValue("foo")
		assert_equal(1,test,"showVariableValue should value we set.")
		assert_raise(RuntimeError) do
			notValid = @klass.showVariableValue("bar")
		end
	end
end