require 'dortha-document'
require 'dortha-token'
require 'dortha-token-stack'

blankArray = [] # I think I should find a way to have this array created when I make a new document.

document = Document.new(blankArray) # Document holds all of the lines from the source file(s) passed as arguments to Dortha.

if ARGV.empty?
	raise "No input file specified. Usage: Dortha.rb [source file name]" # Throw an exception if no source file given.
end

ARGF.each_line do |line|
	lineNumber = ARGF.lineno - 1 # ARGF line numbers seem to start at "1". The document array is zero-indexed.
	document[lineNumber] = line
	if document[lineNumber].match(/$\n/) # Remove trailing newline characters.
		document[lineNumber].chop!
	end
end

document.stripLeadingWhiteSpace
document.parse
test = document.tokenStack.inspect
puts test