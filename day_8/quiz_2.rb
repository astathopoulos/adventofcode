total_size = 0
string_total_size = 0

File.open('input.txt', 'r').each_line do |line|
  dumped_line = line.strip.dump
  string_total_size += line.strip.size
  total_size += dumped_line.size
end

p total_size - string_total_size
