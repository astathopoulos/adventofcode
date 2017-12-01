input_array = File.read('input.txt').strip.each_char.to_a
size = input_array.size
sum = 0

input_array.each_with_index do |number, index|
  sum += number.to_i if number == input_array[(index + size / 2) % size]
end

p sum
