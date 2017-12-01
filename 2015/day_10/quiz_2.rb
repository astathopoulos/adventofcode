def find_next(input)
  previous_char = nil
  next_sequence = []
  current = []
  input.each_char do |char|
    if previous_char == char
      current[1] += 1
    else
      next_sequence << current.reverse if current.size > 0
      previous_char = char
      current = [char, 1]
    end
  end

  next_sequence << current.reverse

  next_sequence.flatten.join('')
end

start = '1321131112'
next_sequence = nil

50.times do
  next_sequence = find_next(start)
  start = next_sequence
end

p next_sequence.size
