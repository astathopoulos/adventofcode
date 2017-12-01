nices = 0

File.open('input.txt', 'r').each_line do |line|
  nices += 1 if line =~ /(\w\w).*(?=\1)/ and line =~ /(\w)\w\1/
end

puts nices
