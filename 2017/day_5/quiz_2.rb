input = File.readlines('input.txt').map{ |line| line.strip.to_i }
range = (0..input.size - 1)
cursor = 0
steps = 0

while range.include?(cursor)
  move = input[cursor]
  if move >= 3
    input[cursor] -= 1
  else
    input[cursor] += 1
  end

  cursor += move

  steps+=1
end

p steps
