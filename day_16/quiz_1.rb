$aunts = {}
$findings = {
  children: 3,
  cats: 7,
  samoyeds: 2,
  pomeranians: 3,
  akitas: 0,
  vizslas: 0,
  goldfish: 5,
  trees: 3,
  cars: 2,
  perfumes: 1
}

File.open('input.txt', 'r').each_line do |line|
  aunt = line.strip.scan(/Sue (\d+): (\w+): (\d+), (\w+): (\d+), (\w+): (\d+)$/).flatten

  $aunts[aunt[0]] = {
    aunt[1].to_sym => aunt[2].to_i,
    aunt[3].to_sym => aunt[4].to_i,
    aunt[5].to_sym => aunt[6].to_i
  }
end

p $aunts.map { |name, attrs|
  $findings.values_at(*attrs.keys) == attrs.values ? name : nil
}.compact.first.to_i
