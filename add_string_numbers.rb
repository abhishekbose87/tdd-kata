class StringCalculatorError < StandardError; end

def add_string_numbers(numbers)
  return 0 if numbers.strip.empty?

  numbers_string_array = numbers.split(/[,\n]/).reject { |num| num.strip.empty? }
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
