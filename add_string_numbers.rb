class StringCalculatorError < StandardError; end

def add_string_numbers(input)
  return 0 if input.strip.empty?

  delimiter, numbers_string = extract_delimiter_and_numbers(input)
  raise StringCalculatorError, "no delimiter passed" if delimiter.strip.empty?

  split_pattern = /[#{Regexp.escape(delimiter)}\n]/
  numbers_string_array = numbers_string.split(split_pattern).reject { |num| num.strip.empty? }
  raise StringCalculatorError, "no numbers passed" if numbers_string_array.length == 0

  numbers = numbers_string_array.map do |num|
    Integer(num)
  rescue ArgumentError
    raise StringCalculatorError, "non-numeric strings passed"
  end

  negative_numbers = numbers.select { |n| n < 0 }
  raise StringCalculatorError, "negative numbers not allowed <#{negative_numbers.join(",")}>" if negative_numbers.length != 0

  sum = 0
  numbers.map do |num|
    sum += num
  end
  return sum
end

def extract_delimiter_and_numbers(input)
  if input.start_with?("//")
    delimiter_split_pattern = /#{Regexp.escape("//")}(.+)\n(.+)/
    match = input.match(delimiter_split_pattern)
    if match
      delimiter = match[1]
      numbers = match[2]
      return delimiter, numbers
    end
  end

  return ",", input
end
