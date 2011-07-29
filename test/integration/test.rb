require 'rubygems'
require 'dortha'
require 'test/unit'

class IntegrationTest < Test::Unit::TestCase

  def test_create_variable
    program = <<-program
      create variable x.
      set x equal to 10.
      show value of x.
    program
    Dortha.execute(program)
  end

end