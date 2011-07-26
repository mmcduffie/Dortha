require 'helper'

class MockToken
  attr_accessor :value
end

class ProgramTest < Test::Unit::TestCase

  def setup
    sentence1 = Dortha::Sentence.new([Dortha::Number.new(1), Dortha::Number.new(2)])
	sentence2 = Dortha::Sentence.new([Dortha::String.new("1"), Dortha::Token.new("create")])
    document = [sentence1, sentence2]
    @program = Dortha::Program.new(document)
  end
  
  def test_convert_tokens
    @program.convert_objects
	puts @program.inspect
  end
end