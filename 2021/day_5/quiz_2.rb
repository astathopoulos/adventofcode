coords = File.read('input.txt').split("\n").
         map { |inst| inst.split(' -> ') }.
         map { |coords| coords.map { |coord| coord.split(',').map(&:to_i) } }

max_x = coords.flatten(1).map(&:last).max
max_y = coords.flatten(1).map(&:first).max
matrix = Array.new(max_x + 1) { Array.new(max_y + 1) { 0 } }

coords.each do |(from, to)|
  x1, y1 = from
  x2, y2 = to

  x_changes = if x1 <= x2
                (x1..x2).to_a
              else
                (x2..x1).to_a.reverse
              end

  y_changes = if y1 <= y2
                (y1..y2).to_a
              else
                (y2..y1).to_a.reverse
              end

  diagonal = x1 != x2 && y1 != y2

  y_changes.each_with_index do |y, y_index|
    if diagonal
      matrix[y][x_changes[y_index]] += 1
    else
      x_changes.each do |x|
        matrix[y][x] += 1
      end
    end
  end
end

p matrix.flatten.select { |v| v >= 2 }.size
