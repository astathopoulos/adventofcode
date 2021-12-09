# frozen_string_literal: true

class Solution
  attr_reader :basins, :heatmap, :low_points, :x_size, :y_size

  def initialize(filename)
    @heatmap = File.read(filename).split("\n")
                   .map { |line| line.chars.map(&:to_i) }
    @basins = []
    @low_points = []
    @x_size = heatmap.first.size
    @y_size = heatmap.size
  end

  def quiz_1
    calculate_low_points

    low_points.map { |(y, x)| heatmap[y][x] + 1 }.sum
  end

  def quiz_2
    calculate_low_points
    calculate_basins

    basins.map(&:size).sort[-3..-1]&.inject(:*)
  end

  def calculate_low_points
    heatmap.each_with_index do |row, y|
      row.each_with_index do |value, x|
        low_points << [y, x] if neighbors_of([y, x]).all? { |(y, x)| heatmap[y][x] > value }
      end
    end
  end

  def calculate_basins
    low_points.each do |low_point|
      basin_candidates = [low_point]
      basin_points = []

      until basin_candidates.empty?
        point = basin_candidates.pop

        basin_points << point

        basin_candidates += calculate_higher_neighbors_of(point)
      end

      basins << basin_points.uniq
    end
  end

  def calculate_higher_neighbors_of(point)
    value = heatmap[point.first][point.last]

    neighbors_of(point).select do |(y, x)|
      heatmap[y][x] < 9 &&
        heatmap[y][x] > value
    end
  end

  def neighbors_of(coords)
    y, x = coords

    [[y - 1, x], [y + 1, x], [y, x - 1], [y, x + 1]].reject do |(y, x)|
      x.negative? || y.negative? || x >= x_size || y >= y_size
    end
  end
end

p Solution.new('input.txt').quiz_1
p Solution.new('input.txt').quiz_2
