$reindeers = {}
$time = 2503

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

max_distance = $reindeers.map { |reindeer, values|
  completed_cycles = $time / values[:cycle]
  time_remaining = $time - completed_cycles * values[:cycle]

  (values[:speed] * values[:duration] * completed_cycles) +
    ([time_remaining, values[:duration]].min * values[:speed])
}.max

p max_distance
