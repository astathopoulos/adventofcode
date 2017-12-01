$containers = []
File.open('input.txt', 'r').each_line do |line|
  $containers << line.strip.to_i
end

combinations = Hash.new(0)
1.upto($containers.size) do |n|
  $containers.combination(n).each do |combination|
    combinations[combination.size] += 1 if combination.inject(:+) == 150
  end
end

p combinations.sort_by { |k, v| k }.first.last
