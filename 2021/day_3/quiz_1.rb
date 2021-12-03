input = File.readlines('input.txt').map { |l| l.chop.chars.map(&:to_i) }

gamma_rate, epsilon_rate = input.transpose.
  map { |ar| ar.partition(&:zero?) }.
  map { |(zeros, ones)| ones.size > zeros.size ? [1, 0] : [0, 1] }.
  transpose.map { |ar| ar.join.to_i(2) }

p [gamma_rate, epsilon_rate]
power_consumption = gamma_rate * epsilon_rate

p power_consumption
