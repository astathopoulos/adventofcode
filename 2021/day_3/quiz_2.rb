input = File.readlines('input.txt').map { |l| l.chop.chars.map(&:to_i) }

zeros, ones = input.partition { |ar| ar.first.zero? }.map(&:size)
oxygen_bit = ones >= zeros ? 1 : 0
co2_bit = zeros <= ones ? 0 : 1

oxygen_values = input.select { |ar| ar[0] == oxygen_bit }
co2_values = input.select { |ar| ar[0] == co2_bit }

index = 1

loop do
  if oxygen_values.size > 1
    zeros, ones = oxygen_values.partition { |ar| ar[index].zero? }.map(&:size)
    oxygen_bit = ones >= zeros ? 1 : 0
    oxygen_values = oxygen_values.select { |ar| ar[index] == oxygen_bit }
  end

  if co2_values.size > 1
    zeros, ones = co2_values.partition { |ar| ar[index].zero? }.map(&:size)
    co2_bit = zeros <= ones ? 0 : 1
    co2_values = co2_values.select { |ar| ar[index] == co2_bit }
  end

  index += 1

  break if oxygen_values.size == 1 && co2_values.size == 1
end

oxygen = oxygen_values.first.join.to_i(2)
co2 = co2_values.first.join.to_i(2)

p oxygen * co2
