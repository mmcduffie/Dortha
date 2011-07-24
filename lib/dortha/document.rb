module Dortha
  # The Document class represents a Dortha source file, and contains
  # methods that operate on each source file, including the lexer.
  class Document < Array
    # Creates a new Document. To create a new Document you need to 
    # provide the initalizer with a string.
    def initialize(source_file)
      code = source_file.gsub!(/(\n|\r)/,"").split(".")
      super(code)
    end
    
    # The lex method is a lexer that takes all of the sentences in the source file and 
    # converts each word into a Token object.
    def lex
      remove_leading_whitespace
      compact_remaining_whitespace
      add_sentence_objects
    end
    
    # The remove_whitespace method deletes leading whitespace from sentences.
    def remove_leading_whitespace
      self.map! { |sentence| sentence = sentence.lstrip }
    end
    
    # The compact_remaining_whitespace method finds whitespace more than one character
    # long in the middle of sentences and replaces it with single spaces.
    def compact_remaining_whitespace
      self.map! { |sentence| sentence = sentence.gsub(/\s{2,}/," ") }
    end
    
    # The add_sentence_objects method is used to seed our document with Sentence objects,
    # which are Arrays that we can add Token objects to later.
    def add_sentence_objects
      length = self.length
      position = 0
      length.times do
        self.insert(position,Dortha::Sentence.new)
        position += 2
      end
    end
	
	def strip_sentences
	  self.each do |sentence|
	    if sentence =~ /(".*")/
		  quoted_string = $1
		end
	  end
	end
  end
end