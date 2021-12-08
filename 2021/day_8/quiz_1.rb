# frozen_string_literal: true

lines = File.read('input.txt').split("\n").
        map { |line| line.split('|') }.
        map { |input| input.map(&:split) }

uniq_digits_length = [2, 4, 3, 7]

p lines.map(&:last).map { |array| array.map(&:size) }.flatten.
  count { |size| uniq_digits_length.include?(size) }
