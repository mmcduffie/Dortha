class Button
  attr_accessor :name
  attr_accessor :callback
  def script_string
    return "$( \"\##{@name}\").button();\n$( \"\##{@name}\").click(#{@callback});"
  end
end