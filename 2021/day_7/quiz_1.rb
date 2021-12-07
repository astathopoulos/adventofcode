# frozen_string_literal: true

input = File.read('input.txt').chop.split(',').map(&:to_i).sort

fuel = Hash.new(0)

(input.min..input.max).each do |v|
  fuel[v] = input.map { |i| (v - i).abs }.sum
end

p fuel.min_by { |(_, v)| v }
