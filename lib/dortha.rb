# The Dortha module is the main namespace for all classes in Dortha.
# To use Dortha, you can simply require this file (/lib/dortha.rb) and
# you will have access to all mothods, modules, and classes in Dortha.
module Dortha
  VERSION = '0.0.0'
  # Returns the current version of Dortha.
  def self.version
    VERSION
  end
  autoload :Document, "dortha/document"
  autoload :Token, "dortha/token"
  autoload :String, "dortha/types/string"
end