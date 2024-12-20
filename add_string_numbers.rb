def add_string_numbers(numbers)
  return 0 if numbers.strip.empty?
  numbers_array = numbers.split(",").reject { |num| num.strip.empty? }
  sum = 0
  numbers_array.map { |num| sum += num.to_i }
  return sum
end
