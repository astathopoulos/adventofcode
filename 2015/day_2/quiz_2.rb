total_wrap = 0

File.open('input.txt', 'r').each_line do |line|
  length, width, height = line.split('x').map(&:to_i)
  dim_1, dim_2 = [length, width, height].sort[0..1]

  wrap = dim_1 * 2 + dim_2 * 2 + (length * width * height)

  total_wrap += wrap
end

p total_wrap
