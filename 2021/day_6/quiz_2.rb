# frozen_string_literal: true

input = File.read('input.txt').chop.split(',').map(&:to_i)

hash = {}
9.times do |i|
  hash[i] = 0
end

fishes = hash.dup

input.each do |fish|
  fishes[fish] += 1
end

256.times do |_|
  new_fishes = hash.dup

  0.upto(7) do |i|
    new_fishes[i] = fishes[i + 1]
  end

  new_fishes[8] = fishes[0]
  new_fishes[6] += fishes[0]

  fishes = new_fishes
end

p fishes.values.sum
