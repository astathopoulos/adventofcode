$reindeers = {}
$last_second = 2503
File.open('input.txt', 'r').each_line do |line|
  reindeer, speed, duration, rest =
    line.strip.scan(
      /(\w+) can fly (\d+) km\/s for (\d+) seconds, but then must rest for (\w+) seconds\./).flatten

  $reindeers[reindeer] = {
    speed: speed.to_i,
    duration: duration.to_i,
    rest: rest.to_i,
    cycle: duration.to_i + rest.to_i
  }
end

scoring = Hash.new(0)
distance_run = {}
1.upto($last_second) do |time|
  $reindeers.each do |reindeer, values|
    completed_cycles = time / values[:cycle]
    time_remaining = time - completed_cycles * values[:cycle]

    distance_run[reindeer] = (values[:speed] * values[:duration] * completed_cycles) +
      ([time_remaining, values[:duration]].min * values[:speed])
  end

  distances = distance_run.sort_by { |k, v| - v }.to_a

  distances.each_with_index do |(reindeer, distance), index|
    if index == 0
      scoring[reindeer] += 1
      next
    end

    break if distance < distances[index - 1].last

    scoring[reindeer] += 1
  end
end

p scoring.values.max
