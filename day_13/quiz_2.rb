$points = {}
File.open('input_2.txt', 'r').each_line do |line|
  name_1, mood, points, name_2 =
    line.strip.scan(/(\w+) would (\w+) (\d+) happiness units by sitting next to (\w+)\./).flatten
  $points[[name_1, name_2]] = mood == 'gain' ? points.to_i : -points.to_i
end

$people = $points.keys.flatten.uniq
max_happiness = $points.keys.flatten.uniq.permutation($people.size).map { |people|
  people.unshift(people[-1])
  people.each_cons(2).map { |pair|
    $points[[*pair]] + $points[[*pair.reverse]]
  }.inject(:+)
}.max

p max_happiness
