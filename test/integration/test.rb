require 'rubygems'
require 'dortha'
require 'test/unit'

class IntegrationTest < Test::Unit::TestCase

  def test_create_variable
    program = <<-program
      create variable x. set x equal 
    program
    document = Dortha::Document.new(program)
    document.lex
    program = Dortha::Program.new(document)
    program.interpret
    puts program.inspect
  end

end