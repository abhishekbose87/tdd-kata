class StringCalculatorError < StandardError; end

def add_string_numbers(numbers)
  return 0 if numbers.strip.empty?
  numbers_array = numbers.split(",").reject { |num| num.strip.empty? }
  raise StringCalculatorError, "no numbers passed" if numbers_array.length == 0
  sum = 0
  numbers_array.map do |num|
    begin
      Integer(num)
    rescue ArgumentError
      raise StringCalculatorError, "non-numeric strings passed"
    end
    raise StringCalculatorError, "negative numbers passed" if num.to_i < 0
    sum += num.to_i
  end
  return sum
end
