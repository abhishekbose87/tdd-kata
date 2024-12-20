class StringCalculatorError < StandardError; end

def add_string_numbers(numbers)
  return 0 if numbers.strip.empty?
  numbers_array = numbers.split(",").reject { |num| num.strip.empty? }
  sum = 0
  numbers_array.map do |num|
    begin
      Integer(num)
    rescue ArgumentError
      raise StringCalculatorError, "Method only accepts numbers"
    end
    sum += num.to_i
  end
  return sum
end
