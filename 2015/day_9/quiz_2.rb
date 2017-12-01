places = []
distances = {}

File.open('input.txt', 'r').each_line do |line|
  from, to, distance = line.strip.scan(/^(.*) to (.*) = (.*)$/).flatten
  places << from
  places << to
  distances[[from, to]] = distance.to_i
end

max_distance = places.uniq.permutation.map { |permutation|
  permutation.each_cons(2).map { |pairs|
    distances[[*pairs]] || distances[[*pairs.reverse]]
  }.reduce(:+)
}.max

p max_distance
