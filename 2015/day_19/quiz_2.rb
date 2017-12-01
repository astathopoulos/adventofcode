$replacements = {}
$positions = {}
$count = 0

File.open('input.txt', 'r').each_line do |line|
  if matching = line.strip.match(/(\w+) => (\w+)/)
    $replacements[matching[2]] = matching[1]
  elsif matching = line.strip.match(/(\w+)/)
    $molecule = matching.to_s
  end
end

$replacements.keys.each do |key|
  i = -1
  while i = $starting_molecule.index(key, i + 1)
    if $positions[key]
      $positions[key] << i
    else
      $positions[key] = [i]
    end
  end
end

while $molecule.chars.to_a.uniq.first != 'e' do
  $replacements.sort_by { |k, v| -k.size }.each do |k, v|
    $molecule.gsub!(/#{k}/) { |sub| $count += 1; v }
  end
  p $count
end
