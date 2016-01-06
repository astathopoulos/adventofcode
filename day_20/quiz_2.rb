$input = 36_000_000

class House
  class << self; attr_accessor :current, :found end
end

House.current = 1
House.found = []

current_mutex = Mutex.new

threads = (1..20).map do |i|
  Thread.new(i) do |i|
    begin
      house = 0
      current_mutex.synchronize do
        house = House.current
        House.current += 1
      end

      presents = 1.upto(Math.sqrt(house)).
        select { |i| house % i == 0 }.
        inject(0) do |presents, factor|
          presents += factor * 11 if factor * 50 >= house

          if factor != (house / factor) and (house / factor) * 50 >= house
            presents += (house / factor) * 11
          end

          presents
        end
      House.found << house if presents >= $input
    end while House.found.empty?
  end
end

threads.each { |t| t.join }

p House.found.min
