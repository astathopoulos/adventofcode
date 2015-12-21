$wires = {}
$cached = {}

File.open('input.txt', 'r').each_line do |line|
  func, var = line.strip.split(' -> ')

  op = func.scan(/(AND|OR|NOT|LSHIFT|RSHIFT)/).flatten.first
  case op
  when 'AND'
    var1, var2 = func.scan(/(.*) AND (.*)/).flatten
    var1 = var1.to_i if var1 =~/\d+/
    var2 = var2.to_i if var2 =~/\d+/

    $wires[var] = -> do
      return $cached[var] if $cached[var]

      $cached[var] = (var1.is_a?(Integer) ? var1 : $wires[var1].call.to_i) &
        (var2.is_a?(Integer) ? var2 : $wires[var2].call.to_i)
    end
  when 'OR'
    var1, var2 = func.scan(/(.*) OR (.*)/).flatten
    var1 = var1.to_i if var1 =~/\d+/
    var2 = var2.to_i if var2 =~/\d+/
    $wires[var] = -> do
      return $cached[var] if $cached[var]

      $cached[var] = (var1.is_a?(Integer) ? var1 : $wires[var1].call.to_i) |
        (var2.is_a?(Integer) ? var2 : $wires[var2].call.to_i)
    end
  when 'NOT'
    var1 = func.scan(/NOT (.*)/).flatten.first
    var1 = var1.to_i if var1 =~/\d+/
    $wires[var] = -> do
      return $cached[var] if $cached[var]

      $cached[var] = 2 ** 16 - 1 - (var1.is_a?(Integer) ? var1 : $wires[var1].call.to_i)
    end
  when 'LSHIFT'
    var1, value = func.scan(/(.*) LSHIFT (.*)/).flatten
    var1 = var1.to_i if var1 =~/\d+/
    $wires[var] = -> do
      return $cached[var] if $cached[var]

      $cached[var] = (var1.is_a?(Integer) ? var1 : $wires[var1].call.to_i) << value.to_i
    end
  when 'RSHIFT'
    var1, value = func.scan(/(.*) RSHIFT (.*)/).flatten
    var1 = var1.to_i if var1 =~/\d+/
    $wires[var] = -> do
      return $cached[var] if $cached[var]

      $cached[var] = (var1.is_a?(Integer) ? var1 : $wires[var1].call.to_i) >> value.to_i
    end
  else
    func = func.to_i if func =~/\d+/
    $wires[var] = -> do
      return $cached[var] if $cached[var]

      $cached[var] = func.is_a?(Integer) ? func : $wires[func].call.to_i
    end
  end
end

p $wires['a'].call
