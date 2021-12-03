input = File.readlines('input.txt').map { |l| l.chop.split }.map { |(dir, value)| [dir, value.to_i] }

position = { horizontal: 0, depth: 0, aim: 0 }

input.each do |(dir, value)|
  case dir
  when 'forward'
    position[:horizontal] += value
    position[:depth] += position[:aim] * value
  when 'up'
    position[:aim] -= value
  when 'down'
    position[:aim] += value
  end
end

p position.values_at(:depth, :horizontal).inject(:*)
