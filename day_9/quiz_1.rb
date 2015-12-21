places = []
distances = {}

File.open('input.txt', 'r').each_line do |line|
  from, to, distance = line.strip.scan(/^(.*) to (.*) = (.*)$/).flatten
  places << from
  places << to
  distances[[from, to]] = distance.to_i
end

min_distance = places.uniq.permutation.map { |permutation|
  permutation.each_cons(2).map { |pairs|
    distances[[*pairs]] || distances[[*pairs.reverse]]
  }.reduce(:+)
}.min

p min_distance
