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
last_winning_board = nil
boards_won = {}

numbers.each_with_index do |number, index|
  next if index < 3

  played_numbers = numbers[0..index]

  winner = nil
  boards.each_with_index do |board, board_index|
    winner = board.any? { |ar| ar.all? { |el| played_numbers.include?(el) } }

    winner ||= inverted_boards[board_index].any? do |ar|
      ar.all? { |el| played_numbers.include?(el) }
    end

    boards_won[board_index] = true if winner

    if boards_won.keys.size == boards.size
      last_winning_board = board_index

      break
    end
  end

  if last_winning_board
    final_number = number
    position = index

    break
  end
end

p boards[last_winning_board].flatten.delete_if { |number| numbers[0..position].include?(number) }.sum * final_number
