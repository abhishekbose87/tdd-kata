class StringCalculatorError < StandardError; end

class StringCalculatorInput
  def initialize(input)
    @input = input
  end

  def numbers
    extract_delimiter_and_numbers
    parse_numbers_string
    validate_numbers
    return @numbers
  end

  private

  def extract_delimiter_and_numbers
    if @input.start_with?("//")
      delimiter_split_pattern = /#{Regexp.escape("//")}(.+)\n(.+)/
      match = @input.match(delimiter_split_pattern)
      if match
        @delimiter = match[1]
        @numbers_string = match[2]
      end
    else
      @delimiter = ","
      @numbers_string = @input
    end

    raise StringCalculatorError, "no delimiter passed" if @delimiter.strip.empty?
  end

  def parse_numbers_string
    split_pattern = /[#{Regexp.escape(@delimiter)}\n]/
    numbers_string_array = @numbers_string.split(split_pattern).reject { |num| num.strip.empty? }

    @numbers = numbers_string_array.map do |num|
      Integer(num)
    rescue ArgumentError
      raise StringCalculatorError, "non-numeric strings passed"
    end
  end

  def validate_numbers
    negative_numbers = @numbers.select { |n| n < 0 }
    if negative_numbers.any?
      raise StringCalculatorError, "negative numbers not allowed <#{negative_numbers.join(",")}>"
    end
  end
end

def add_string_numbers(input)
  calculator_input = StringCalculatorInput.new(input)
  calculator_input.numbers.sum
end
