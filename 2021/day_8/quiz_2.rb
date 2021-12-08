# frozen_string_literal: true

lines = File.read('input.txt').split("\n").
        map { |line| line.split('|') }.
        map { |input| input.map(&:split) }

output = lines.map do |sample, values|
  sample = sample.map { |input| input.chars.sort.join }
  values = values.map { |input| input.chars.sort.join }

  one = sample.find { |input| input.size == 2 }
  four = sample.find { |input| input.size == 4 }
  seven = sample.find { |input| input.size == 3 }
  eight = sample.find { |input| input.size == 7 }

  zero_six_nine = sample.select { |input| input.size == 6 }
  two_three_five = sample.select { |input| input.size == 5 }

  three = two_three_five.find { |number| (one.chars - number.chars).empty? }
  six = zero_six_nine.find { |number| (one.chars - number.chars).size == 1 }

  left = six.chars - three.chars
  bottom_left = (left - four.chars).first

  zero = (zero_six_nine - [six]).find { |number| (left - number.chars).empty? }
  nine = (zero_six_nine - [six, zero]).first

  two = (two_three_five - [three]).find { |number| number.chars.include?(bottom_left) }
  five = (two_three_five - [three, two]).first

  mapping = {
    zero => 0,
    one => 1,
    two => 2,
    three => 3,
    four => 4,
    five => 5,
    six => 6,
    seven => 7,
    eight => 8,
    nine => 9
  }

  values.map { |v| mapping[v] }.join.to_i
end

p output.sum
