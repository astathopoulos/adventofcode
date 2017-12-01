$rows = 1000
$cols = 1000
$grid = Array.new($rows * $cols, 0)

def grid_to_vector(x, y)
  y * $cols + x
end

def ranges(from_x, from_y, to_x, to_y)
  ranges = []
  (from_y).upto(to_y) do |n|
    ranges << (grid_to_vector(from_x, n)..grid_to_vector(to_x,n))
  end

  ranges
end

File.open('input.txt', 'r').each_line do |line|
  command, from, to = line.scan(/^([\w\s]+)\s(\d+,\d+)\s\w+\s(\d+,\d+)$/).flatten
  from_dimensions = from.split(',').map(&:to_i)
  to_dimensions = to.split(',').map(&:to_i)

  ranges = ranges(*from_dimensions, *to_dimensions)
  case command
  when 'turn on'
    ranges.each { |range| range.each { |i| $grid[i] += 1 } }
  when 'turn off'
    ranges.each { |range| range.each { |i| $grid[i] = [$grid[i] - 1, 0].max } }
  when 'toggle'
    ranges.each { |range| range.each { |i| $grid[i] += 2 } }
  end
end

puts $grid.inject(:+)
