total_wrap = 0

File.open('input.txt', 'r').each_line do |line|
  length, width, height = line.split('x').map(&:to_i)
  side_1 = length * width
  side_2 = width * height
  side_3 = height * length

  smallest_side = [side_1, side_2, side_3].min

  wrap = (2 * side_1 + 2 * side_2 + 2 * side_3) + smallest_side

  total_wrap += wrap
end

p total_wrap
