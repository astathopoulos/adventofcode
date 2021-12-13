# frozen_string_literal: true

class Solution
  attr_reader :dots, :folding_instructions, :max_x, :max_y, :sheet

  def initialize(filename)
    dots, folding = File.read(filename).split("\n\n")

    @dots = dots.split("\n").map { |line| line.split(',').map(&:to_i) }

    @max_x = @dots.map(&:first).max
    @max_y = @dots.map(&:last).max

    @sheet = Array.new(max_y + 1) { Array.new(max_x + 1) { nil } }

    @folding_instructions = folding.split("\n").map do |line|
      direction, number = line.split('=')

      [direction, number.to_i]
    end
  end

  def quiz_1
    draw_dots
    apply_folding(1)

    pp sheet.flatten.select { |v| v == true }.size
  end

  def quiz_2
    draw_dots
    apply_folding

    pp sheet.map { |row| row.map { |el| el ? '#' : '.'}.join }
  end

  def draw_dots
    dots.each do |(x, y)|
      sheet[y][x] = true
    end
  end

  def apply_folding(steps = nil)
    instructions =
      steps.nil? ? folding_instructions : folding_instructions.first(steps)

    instructions.each do |(direction, line)|
      case direction
      when 'fold along x'
        vertical_flip(line)
      when 'fold along y'
        horizontal_flip(line)
      end
    end
  end

  def horizontal_flip(line)
    new_sheet = sheet[0..line - 1].dup

    sheet[line + 1..-1].each_with_index do |row, y|
      break if y >= line

      row.each_with_index do |value, x|
        new_sheet[line - 1 - y][x] ||= value
      end
    end

    @sheet = new_sheet
  end

  def vertical_flip(line)
    new_sheet = sheet.map { |row| row[0..line - 1] }

    sheet.each_with_index do |row, y|
      row[line + 1..-1].each_with_index do |value, x|
        next if x >= line

        new_sheet[y][line - x - 1] ||= value
      end
    end

    @sheet = new_sheet
  end
end

Solution.new('input.txt').quiz_1
Solution.new('input.txt').quiz_2
