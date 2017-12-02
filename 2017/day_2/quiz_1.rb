puts File.readlines('input.txt').map { |line| line.strip.split("\t").map(&:to_i) }.inject(0) { |sum, row| sum + row.max - row.min }
