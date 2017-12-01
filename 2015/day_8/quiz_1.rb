total_size = 0
string_total_size = 0

File.open('input.txt', 'r').each_line do |line|
  actual_line = eval(line.strip)
  string_total_size += actual_line.chars.to_a.size
  total_size += line.strip.size
end

p total_size - string_total_size
