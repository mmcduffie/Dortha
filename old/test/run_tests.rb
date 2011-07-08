Dir.glob('test*.rb').each do |file|
	require file # Forces all tests to be part of test suite.
end
Dir.glob('../test/types/test*.rb').each do |file|
	require file # Need a better way to load tests from subdirectories.
end