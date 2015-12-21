$ingredients = {}

File.open('input.txt', 'r').each_line do |line|
  ingredient, capacity, durability, flavor, texture, calories =
    line.strip.
    scan(
      /^(\w+): capacity (-?\w+), durability (-?\w+), flavor (-?\w+), texture (-?\w+), calories (-?\w+)/).flatten

    $ingredients[ingredient] = {
      capacity: capacity.to_i,
      durability: durability.to_i,
      flavor: flavor.to_i,
      texture: texture.to_i,
      calories: calories.to_i
    }
end

scores = $ingredients.keys.repeated_combination(100).map do |combination|
  score = Hash.new(0)

  combination.each do |ingredient|
    score[:capacity] += $ingredients[ingredient][:capacity]
    score[:durability] += $ingredients[ingredient][:durability]
    score[:flavor] += $ingredients[ingredient][:flavor]
    score[:texture] += $ingredients[ingredient][:texture]
    score[:calories] += $ingredients[ingredient][:calories]
  end

  score
end

p scores.map(&:values).
    map {|array| array.map {|el| el < 0 ? 0 : el } }.
    map { |array| [array[0..-2].inject(:*), array[-1]] }.
    select { |array| array[1] == 500 }.
    map(&:first).max
