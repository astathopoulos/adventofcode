input = 368078
coordinates = [0, 0]
move = :right
max_x = 0

moves = {
  right: { action: ->(x, y) { [x + 1, y] }, condition: -> (x, y) { x == max_x + 1 && max_x += 1 }, next_move: :up },
  up:    { action: ->(x, y) { [x, y + 1] }, condition: -> (x, y) { x == y }, next_move: :left },
  left:  { action: ->(x, y) { [x - 1, y] }, condition: -> (x, y) { x == -max_x }, next_move: :down },
  down:  { action: ->(x, y) { [x, y - 1] }, condition: -> (x, y) { x == y }, next_move: :right }
}

(2..input).each do |i|
  move = moves[move][:next_move] if moves[move][:condition].call(*coordinates)

  coordinates = moves[move][:action].call(*coordinates)
end

p coordinates.map(&:abs).reduce(:+)
