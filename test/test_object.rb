require '../lib/dortha-object.rb'
require 'test/unit'

class ThingTest < Test::Unit::TestCase
	def setup
		@thing = Thing.new # We call objects "Things" so they don't trip over Ruby's built-in Object class.
	end
	def test_addInstanceVariable
		@thing.addInstanceVariable("foo")
		test = @thing.InstanceVariables
		assert_equal(["foo"],test,"Should return one variable name")
		@thing.addInstanceVariable("foo")
		test = @thing.InstanceVariables
		assert_equal(["foo"],test,"Adding an instance varable of the same name should not create a duplicate.")
	end
	def test_assignment
		@thing.addInstanceVariable("foo")
		@thing.addInstanceVariable("bar")
		@thing.assignValue(1,"foo") # Value to assign, variable to assign it to.
		@thing.assignValue(2,"bar")
		assert_raise(RuntimeError) do
			notValid = @thing.assignValue(1,"notRealVar")
		end
		test1 = @thing.getValue("foo")
		test2 = @thing.getValue("bar")
		assert_raise(RuntimeError) do
			notValid = @thing.getValue("notRealVar")
		end
		assert_equal(1,test1,"Value not what we expected.")
		assert_equal(2,test2,"Value not what we expected.")
	end
	def test_reassignment
		@thing.addInstanceVariable("foo")
		@thing.assignValue(1,"foo") # Value to assign, variable to assign it to.
		@thing.assignValue(2,"foo")
		test = @thing.getValue("foo")
		assert_equal(2,test,"Value should change after reassignment.")
	end
	def test_klass
		@thing.klass = "foo"
		assert_equal("foo",@thing.klass,"Klass should be foo.")
	end
end