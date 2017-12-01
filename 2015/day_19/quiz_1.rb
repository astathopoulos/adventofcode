$replacements = {}
$molecules = []
$positions = {}
File.open('input.txt', 'r').each_line do |line|
  if matching = line.strip.match(/(\w+) => (\w+)/)
    if $replacements[matching[1]]
      $replacements[matching[1]] << matching[2]
    else
      $replacements[matching[1]] = [matching[2]]
    end
  elsif matching = line.strip.match(/(\w+)/)
    $starting_molecule = matching.to_s
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

molecule = $starting_molecule.dup
$positions.each do |atom, positions|
  positions.each do |starting|
    $replacements[atom].each do |replacement|
      ending = atom.size + starting - 1
      molecule[starting..ending] = replacement
      $molecules << molecule
      molecule = $starting_molecule.dup
    end
  end
end

p $molecules.uniq.size
