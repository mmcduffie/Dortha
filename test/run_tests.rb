Dir.glob('test*.rb').each do |file|
	require file # Forces all tests to be part of test suite.
end