class ValidationErrors
  attr_reader :error_messages, :line_number, :line_contents
  def initialize(opts)
    @error_messages = opts[:errors]
    @line_number = opts[:line_number]
    @line_contents = opts[:line_contents]
  end

  def dump
    "Line #: #{line_number}\nLine: #{line_contents}\n" << error_messages.join(", ")
  end
end


