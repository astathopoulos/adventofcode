input = File.open('input.txt', 'r').read

direction = {
  '(' => :+,
  ')' => :-
}

floor = 0
position = 0

input.chars.each_with_index do |char, index|
  floor = floor.send(direction[char], 1)

  if floor < 0
    position = index
    break
  end
end

p position
