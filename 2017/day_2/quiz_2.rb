puts File.readlines('input.txt').map { |line| line.strip.split("\t").map(&:to_i) }.inject(0) { |sum, row|
  elements = row.combination(2).find { |elements| elements.sort! && elements[1] % elements[0] == 0  }
  sum + (elements.max / elements.min)
}
