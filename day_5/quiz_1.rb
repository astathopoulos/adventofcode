nices = 0

File.open('input.txt', 'r').each_line do |line|
  next if line =~ /(ab|cd|pq|xy)/

  nices += 1 if line =~ /(\w)\1{1,}/ && line.scan(/[aeiou]/).size >= 3
end

puts nices
