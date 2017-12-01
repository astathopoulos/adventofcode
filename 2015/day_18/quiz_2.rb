$cols = 100
$rows = 100
$steps = 100
$grid = {}

def corner?(x, y)
  [[0, 0], [0, $cols - 1], [$rows - 1, 0], [$rows - 1, $cols - 1]].include?([x, y])
end

File.open('input.txt', 'r').each_line.with_index do |line, row|
  line.strip.gsub('.', '0').gsub('#', '1').chars.map(&:to_i).each_with_index do |light, col|
    $grid[[row, col]] = corner?(row, col) ? 1 : light
  end
end

def neighbours(x, y)
  ((x - 1)..(x + 1)).to_a.product(((y - 1)..(y + 1)).to_a).select { |col, row|
    col >= 0 && row >= 0 && !(col == x && row == y) && col < $cols && row < $rows
  }.to_a
end

$steps.times do
  new_grid = {}
  $grid.each do |(x,y), light|
    neighbouring_lights = $grid.values_at(*neighbours(x,y)).inject(:+)
    new_grid[[x,y]] = if corner?(x, y) or (light == 0 and neighbouring_lights == 3)
                        1
                      elsif light == 1 and
                        (neighbouring_lights < 2 or neighbouring_lights > 3)
                        0
                      else
                        light
                      end
  end
  $grid = new_grid.dup
end

p $grid.values.inject(:+)
