Gem::Specification.new do |spec|
  spec.name = 'dortha'
  spec.version = '0.0.0'
  spec.description = 'Dortha is an English-language inspired programing language. Like English, we use sentances and words to convey meaning. Unlike other object-oriented languages were the object we are calling methods on is to the left of the method call, dortha is reversed.'
  spec.summary = 'An English-language-inspired, object-oriented, imperative programming language.'
  spec.author = 'Marcus McDuffie'
  spec.email = 'whitehatpsycho@gmail.com'
  spec.homepage = 'http://www.marcusmcduffie.com/'
  
  spec.files = Dir['lib/**/*.rb'] + Dir['bin/*']
  spec.add_dependency('rake')
end