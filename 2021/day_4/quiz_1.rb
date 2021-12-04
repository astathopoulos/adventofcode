# frozen_string_literal: true

input = File.read('input.txt')

strings = input.split("\n\n")

numbers = strings.first.split(',').map(&:to_i)

# array of arrays which contains the rows of each matrix
boards = strings[1..-1].map { |s| s.split("\n") }.
         map { |ar| ar.map(&:split).map { |inner_ar| inner_ar.map(&:to_i) } }

# array of arrays which contanins the columns of each matrix
inverted_boards = boards.map(&:transpose)

final_number = nil
position = nil
winning_board = nil

numbers.each_with_index do |number, index|
  next if index < 3

  played_numbers = numbers[0..index]

  winner = nil
  boards.each_with_index do |board, board_index|
    winner = board.any? { |ar| ar.all? { |el| played_numbers.include?(el) } }

    winner ||= inverted_boards[board_index].any? do |ar|
      ar.all? { |el| played_numbers.include?(el) }
    end

    if winner
      winning_board = board_index

      break
    end
  end

  if winner
    final_number = number
    position = index

    break
  end
end

p boards[winning_board].flatten.delete_if { |number| numbers[0..position].include?(number) }.sum * final_number
