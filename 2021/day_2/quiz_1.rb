input = File.readlines('input.txt').map { |l| l.chop.split }.map { |(dir, value)| [dir, value.to_i] }

position = { horizontal: 0, depth: 0 }

input.each do |(dir, value)|
  case dir
  when 'forward'
    position[:horizontal] += value
  when 'up'
    position[:depth] -= value
  when 'down'
    position[:depth] += value
  end
end

p position.values.inject(:*)
