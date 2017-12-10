banks = File.read('input.txt').strip.split("\t").map(&:to_i)
configurations = []
steps = 0
current_configuration = banks.join

while(!configurations.include?(current_configuration))
  configurations << current_configuration

  max = banks.max
  start = banks.index(max)
  banks[start] = 0
  max.times do |i|
    banks[(start + 1 + i) % banks.size] += 1
  end

  current_configuration = banks.join
  steps += 1
end

p steps
