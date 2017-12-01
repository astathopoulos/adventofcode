input_array = File.read('input.txt').strip.each_char.to_a
initial = input_array[0] == input_array[-1] ? input_array[0].to_i : 0
p input_array.each_cons(2).inject(initial) { |sum, cons| cons[0] == cons[1] ? sum + cons[0].to_i : sum }
