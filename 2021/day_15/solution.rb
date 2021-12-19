# frozen_string_literal: true

# Day 15 solution
class Solution
  attr_reader :grid, :y_size, :x_size, :distances

  def initialize(filename)
    @grid = File.read(filename).split("\n").map { |line| line.chars.map(&:to_i) }

    @y_size = grid.size
    @x_size = grid.first.size
    @distances = Hash.new(Float::INFINITY)
    @distances[[0, 0]] = 0
  end

  def quiz_1
    dijsktra

    p distances[[y_size - 1, x_size - 1]]
  end

  def quiz_2
    @grid = calculate_extended_grid

    @y_size = grid.size
    @x_size = grid.first.size

    dijsktra

    p distances[[y_size - 1, x_size - 1]]
  end

  def dijsktra
    nodes_to_follow = [[0, 0]]

    until nodes_to_follow.empty?
      node = nodes_to_follow.min_by { |candidate| distances[candidate] }

      neighbors_of(node).each do |neighbor|
        new_distance = grid[neighbor.first][neighbor.last] + distances[node]

        next if new_distance >= distances[neighbor]

        distances[neighbor] = new_distance
        # found shortest distance, examine this node
        nodes_to_follow << neighbor
      end

      nodes_to_follow.delete(node)
    end
  end

  def neighbors_of(coords)
    y, x = coords

    [[y - 1, x], [y + 1, x], [y, x - 1], [y, x + 1]].reject do |(y, x)|
      x.negative? || y.negative? || x >= x_size || y >= y_size
    end
  end

  def calculate_extended_grid
    grid.each_with_object([]).with_index do |(row, extended_grid), i|
      new_row = []

      5.times do |num|
        new_row += row.map { |val| calculate_value(val, num) }
      end

      5.times do |num|
        index = i + (y_size * num)

        extended_grid[index] = new_row.map { |val| calculate_value(val, num) }
      end
    end
  end

  def calculate_value(value, increase)
    new_value = value + increase

    return new_value - 9 if new_value > 9

    new_value
  end
end

Solution.new('input.txt').quiz_1
Solution.new('input.txt').quiz_2
