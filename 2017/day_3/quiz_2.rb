input = 368078
x = y = 0
move = :right
max_x = 0
value = 1
matrix = {}
matrix[0] = Hash.new(0)
matrix[0][0] =  1

moves = {
  right: { action: ->(x, y) { [x + 1, y] }, condition: -> (x, y) { x == max_x + 1 && max_x += 1 }, next_move: :up },
  up:    { action: ->(x, y) { [x, y + 1] }, condition: -> (x, y) { x == y }, next_move: :left },
  left:  { action: ->(x, y) { [x - 1, y] }, condition: -> (x, y) { x == -max_x }, next_move: :down },
  down:  { action: ->(x, y) { [x, y - 1] }, condition: -> (x, y) { x == y }, next_move: :right }
}

while value < input do
  move = moves[move][:next_move] if moves[move][:condition].call(x, y)
  x, y = moves[move][:action].call(x, y)

  sum = 0

  if matrix[x-1]
    sum += matrix[x-1][y+1] + matrix[x-1][y] + matrix[x-1][y-1]
  end

  if matrix[x]
    sum += matrix[x][y+1] + matrix[x][y-1]
  end

  if matrix[x+1]
    sum += matrix[x+1][y] + matrix[x+1][y+1] + matrix[x+1][y-1]
  end

  value = sum

  matrix[x] = Hash.new(0) unless matrix[x]

  matrix[x][y] = value
end

p value
