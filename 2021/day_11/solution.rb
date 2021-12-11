# frozen_string_literal: true

class Solution
  MAX_ENERGY = 9
  attr_reader :grid, :x_size, :y_size, :flash_buffer, :flashes

  def initialize(filename)
    @grid = File.read(filename)
                .split("\n")
                .map { |line| line.chars.map(&:to_i) }

    @x_size = grid.first.size
    @y_size = grid.size
  end

  def quiz_1
    @flashes = 0

    100.times do
      @flash_buffer = []
      next_step
      affect_adjacents_after_flash
    end

    flashes
  end

  def quiz_2
    step = 0
    @flashes = 0

    until grid.flatten.all?(&:zero?)
      @flash_buffer = []
      next_step
      affect_adjacents_after_flash

      step += 1
    end

    step
  end

  def next_step
    grid.each_with_index do |row, y|
      row.each_with_index do |val, x|
        val += 1

        if val > MAX_ENERGY
          @flashes += 1
          flash_buffer << [y, x] unless flash_buffer.include?([y, x])
        end

        grid[y][x] = val > MAX_ENERGY ? 0 : val
      end
    end
  end

  def affect_adjacents_after_flash
    until flash_buffer.empty?
      point = flash_buffer.pop
      increase_adjacents(point)
    end
  end

  def increase_adjacents(point)
    adjacent_points(point).each do |(y, x)|
      old_val = grid[y][x]

      # already flashed, skip
      next if old_val.zero?

      val = old_val + 1

      if val > MAX_ENERGY
        flash_buffer << [y, x] unless flash_buffer.include?([y, x])
        @flashes += 1

        grid[y][x] = 0

        next
      end

      grid[y][x] = val
    end
  end

  def adjacent_points(point)
    y, x = point

    adjacent_points = []
    (y - 1..y + 1).each do |y_value|
      next if y_value.negative?
      next if y_value >= y_size

      (x - 1..x + 1).each do |x_value|
        next if x_value.negative?
        next if x_value >= x_size

        adjacent_points << [y_value, x_value]
      end
    end

    adjacent_points
  end
end

p Solution.new('input.txt').quiz_1
p Solution.new('input.txt').quiz_2
