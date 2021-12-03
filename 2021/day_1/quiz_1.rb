result = File.readlines('input.txt').map { |l| l.chop.to_i }.each_with_object({}) do |input, hash|
  if hash[:previous].nil?
    hash[:previous] = input

    next
  end

  if hash[:previous] < input
    hash[:increased] = hash[:increased].to_i + 1
  elsif hash[:previous] > input
    hash[:reduced] = hash[:reduced].to_i + 1
  end

  hash[:previous] = input
end

p result

p result[:increased]
