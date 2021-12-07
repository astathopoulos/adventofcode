# frozen_string_literal: true

input = File.read('input.txt').chop.split(',').map(&:to_i).sort

fuel = Hash.new(0)

(input.min..input.max).each do |v|
  fuel[v] = input.map { |i| 1.upto((v - i).abs).to_a.sum }.sum
end

p fuel.min_by { |(_, v)| v }
