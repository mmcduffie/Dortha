require '../lib/dortha-instance-method.rb'
require 'test/unit'

class InstanceMethodTest < Test::Unit::TestCase
	def setup
		@class = Klass.new("test")
		@method = InstanceMethod.new("foo","test") # TODO - Need to make sure that we can add methods to existing classes.
	end
	def test_methodName
		test = @method.methodName
		assert_equal("foo",test,"Name of function not what we set it to.")
	end
	def test_methodRegexp
		test = @method.methodRegexp("foo")
		assert_equal("foo",test,"When method name has no underscores, this should return what it recived.")
		test = @method.methodRegexp("add _ to")
		assert_equal(/add .* to/,test,"This call should return a regexp object of the expected format.")
		test = @method.methodRegexp(" _ my face _ with")
		assert_equal(/ .* my face .* with/,test,"This call should return a regexp object of the expected format.")
	end
end