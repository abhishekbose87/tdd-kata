class StringCalculatorError < StandardError; end

class StringCalculatorInput
  DEFAULT_DELIMITER = ","
  CUSTOM_DELIMITER_PATTERN = %r{//(.+)\n(.+)}

  def initialize(input)
    @input = input
  end

  def numbers
    @numbers ||= parse_and_validate
  end

  private

  def parse_and_validate
    delimiter, numbers_string = parse_input
    validate_delimiter!(delimiter)
    numbers = extract_numbers(numbers_string, delimiter)
    validate_negative_numbers!(numbers)
    numbers
  end

  def parse_input
    if @input.start_with?("//")
      match = @input.match(CUSTOM_DELIMITER_PATTERN)
      return [match[1], match[2]] if match
    end
    [DEFAULT_DELIMITER, @input]
  end

  def validate_delimiter!(delimiter)
    raise StringCalculatorError, "no delimiter passed" if delimiter.strip.empty?
  end

  def extract_numbers(numbers_string, delimiter)
    split_pattern = /[#{Regexp.escape(delimiter)}\n]/
    numbers_string.split(split_pattern)
      .reject { |num| num.strip.empty? }
      .map { |num| parse_number(num) }
  end

  def parse_number(num)
    Integer(num)
  rescue ArgumentError
    raise StringCalculatorError, "non-numeric strings passed"
  end

  def validate_negative_numbers!(numbers)
    negative_numbers = numbers.select(&:negative?)
    if negative_numbers.any?
      raise StringCalculatorError, "negative numbers not allowed <#{negative_numbers.join(",")}>"
    end
  end
end

def add_string_numbers(input)
  StringCalculatorInput.new(input).numbers.sum
end
