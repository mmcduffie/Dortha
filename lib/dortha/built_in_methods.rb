module Dortha
  DORTHA_METHODS = { :create_and_set_variable => /create variable \w+ and set to \w+/, 
                     :create_variable => /create variable \w+/,
                     :show_value_of => /show value of \w+/ }
end
sentence_to_match = "show value of x"
method_to_call = nil
Dortha::DORTHA_METHODS.each do |key, value|
  method_to_call = key if sentence_to_match.match(value)
end
def show_value_of
  puts "called show_value_of using a regexp in a hash!"
end
send(method_to_call)