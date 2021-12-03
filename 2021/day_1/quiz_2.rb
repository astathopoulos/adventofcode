input = File.readlines('input.txt').map { |l| l.chop.to_i }

result = {}

input.each_with_index do |_, index|
  next if index < 3

  a = input[index - 3..index - 1].sum
  b = input[index - 2..index].sum

  if a < b
    result[:increased] = result[:increased].to_i + 1
    p [b, 'increased']
  elsif a > b
    result[:reduced] = result[:reduced].to_i + 1
    p [b, 'reduced']
  else
    p [b, 'no change']
  end
end

p result
