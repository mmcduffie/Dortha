module Dortha
  module Callable
    def find_sentence_signature(regexp)
      message_array = regexp.map do |word|
        word.value
      end
      message = message_array.join(" ")
      method_to_call = nil
      @SENTENCE_SIGNATURES.each do |key, value|
        method_to_call = key if message.match(value)
      end
      method_to_call
    end
    def find_sentence_signature_regexp(method_to_call)
      @SENTENCE_SIGNATURES[method_to_call]
    end
  end
end