# The Dortha module is the main namespace for all classes in Dortha.
# To use Dortha, you can simply require this file (/lib/dortha.rb) and
# you will have access to all mothods, modules, and classes in Dortha.
module Dortha
  
  VERSION = '0.0.0'
  
  autoload :Document, "dortha/document"
  autoload :Token, "dortha/token"
  autoload :String, "dortha/types/string"

  # This is the main exec for Dortha. This should get called weather we
  # are invoking Dortha from the command line after insalling as a gem or 
  # using Dortha as a required library.
  def self.execute(source_file)
    document = Dortha::Document.new(source_file)
    document.lex
  end
end