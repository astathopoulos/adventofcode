input = File.open('input.txt', 'r').read
p input.scan(/(\()/).size - input.scan(/(\))/).size
