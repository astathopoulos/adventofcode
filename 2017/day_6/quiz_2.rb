banks = File.read('input.txt').strip.split("\t").map(&:to_i)
configurations = {}
steps = 0
current_configuration = banks.join

loop do
  if configurations[current_configuration].nil?
    configurations[current_configuration] = [steps]
  else
    configurations[current_configuration] << steps

    break if configurations[current_configuration].size > 1
  end

  max = banks.max
  start = banks.index(max)
  banks[start] = 0
  max.times do |i|
    banks[(start + 1 + i) % banks.size] += 1
  end

  current_configuration = banks.join
  steps += 1
end

p configurations[current_configuration].last - configurations[current_configuration].first
