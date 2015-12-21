require 'json'

class JsonParser
  def initialize(file)
    @json = JSON.parse(file)
    @values = []
  end

  def extract_values(data)
    case data
    when Hash
      data.values.map { |value| extract_values(value) }.inject(:+)
    when Array
      data.map { |value| extract_values(value) }.inject(:+)
    when Integer
      data
    else
      0
    end
  end

  def sum_values
    extract_values(@json)
  end
end

file = File.open('input.txt', 'r')
parser = JsonParser.new(file.read)
p parser.sum_values
file.close
