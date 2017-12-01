positions = Hash.new(0)
position = [[0,0],[0,0]]

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

positions[position[0].join(',')] += 1
positions[position[1].join(',')] += 1

File.open('input.txt', 'r').each_line do |line|
  line.chars.each_with_index do |char, index|
    which = index % 2
    position[which][dimensions[char]] =
      position[which][dimensions[char]].send(operations[char], 1)
    positions[position[which].join(',')] += 1
  end
end

p positions.keys.size
