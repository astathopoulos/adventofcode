# frozen_string_literal: true

fishes = File.read('input.txt').chop.split(',').map(&:to_i)

80.times do |_|
  new_fishes = 0

  fishes.each_with_index do |fish, index|
    if fish.zero?
      fishes[index] = 6
      new_fishes += 1
    else
      fishes[index] = fish - 1
    end
  end

  new_fishes.times do |_|
    fishes.append(8)
  end
end

p fishes.size
