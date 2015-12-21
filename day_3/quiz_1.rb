positions = Hash.new(0)
current_position = [0,0]

operations = {
  '^' => :+,
  'v' => :-,
  '>' => :+,
  '<' => :-
}

dimensions = {
  '^' => 0,
  'v' => 0,
  '>' => 1,
  '<' => 1
}

positions[current_position.join(',')] += 1

File.open('input.txt', 'r').each_line do |line|
  line.chars.each do |char|
    current_position[dimensions[char]] =
      current_position[dimensions[char]].send(operations[char], 1)
    positions[current_position.join(',')] += 1
  end
end

p positions.keys.size
