input = File.readlines('input.txt').map{ |line| line.strip.to_i }
range = (0..input.size - 1)
cursor = 0
steps = 0

while range.include?(cursor)
  move = input[cursor]
  input[cursor] += 1
  cursor += move

  steps+=1
end

p steps
