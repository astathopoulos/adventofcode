puts File.readlines('input.txt').inject(0) { |sum, line|
  words = line.strip.split(' ').map { |word| word.chars.sort.join }
  sum += 1 if words.size == words.uniq.size
  sum
}
