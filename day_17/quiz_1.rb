$containers = []
File.open('input.txt', 'r').each_line do |line|
  $containers << line.strip.to_i
end

p 1.upto($containers.size).map { |n|
  $containers.combination(n).map do |combination|
    combination.inject(:+) == 150 ? 1 : nil
  end
}.flatten.compact.reduce(:+)
