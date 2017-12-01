$cols = 100
$rows = 100
$steps = 100
$grid = {}
$new_grid = {}

File.open('input.txt', 'r').each_line.with_index do |line, row|
  line.strip.gsub('.', '0').gsub('#', '1').chars.map(&:to_i).each_with_index do |light, col|
    $grid[[row, col]] = light
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
    new_grid[[x, y]] = if light == 0 and neighbouring_lights == 3
                         1
                       elsif light == 1 and ![2,3].include?(neighbouring_lights)
                         0
                       else
                         light
                       end
  end

  $grid = new_grid.dup
end

p $grid.values.inject(:+)
