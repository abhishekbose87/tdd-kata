module StringCalculator
  class Error < StandardError; end

  class Input
    DEFAULT_DELIMITER = ","
    CUSTOM_DELIMITER_PATTERN = %r{//(.+)\n(.+)}

    def initialize(input)
      raise Error, "not a string" unless input.is_a?(String)
      @input = input
    end

    def numbers_with_delimiter
      @numbers_with_delimiter ||= parse_and_validate
    end

    private

    def parse_and_validate
      delimiter, numbers_string = parse_input
      validate_delimiter!(delimiter)
      numbers = extract_numbers(numbers_string, delimiter)
      validate_negative_numbers!(numbers)
      {
        delimiter: delimiter,
        numbers: numbers,
      }
    end

    def parse_input
      if @input.start_with?("//")
        match = @input.match(CUSTOM_DELIMITER_PATTERN)
        return [match[1], match[2]] if match
      end
      [DEFAULT_DELIMITER, @input]
    end

    def validate_delimiter!(delimiter)
      raise Error, "no delimiter passed" if delimiter.strip.empty?
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
      raise Error, "non-numeric strings passed"
    end

    def validate_negative_numbers!(numbers)
      negative_numbers = numbers.select(&:negative?)
      if negative_numbers.any?
        raise Error, "negative numbers not allowed <#{negative_numbers.join(",")}>"
      end
    end
  end
end

def add(input)
  result = StringCalculator::Input.new(input).numbers_with_delimiter
  delimiter = result[:delimiter]
  numbers = result[:numbers]
  if (delimiter == "*")
    multiply(numbers)
  else
    sum(numbers)
  end
end

def sum(numbers)
  numbers.sum
end

def multiply(numbers)
  numbers.inject { |res, num| res * num }

  # numbers.each do |num|
  #   result *= num
  # end
  # result
end
