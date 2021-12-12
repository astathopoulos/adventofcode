# frozen_string_literal: true

class Solution
  attr_reader :connections, :nodes, :pairs, :possible_paths, :part

  def initialize(filename)
    @pairs = File.read(filename)
                 .split("\n")
                 .map { |line| line.split('-') }

    initialize_nodes
    initialize_connections
  end

  def quiz_1
    @part = :part_1
    @possible_paths = []

    dfs('start', [], Hash.new(0))

    possible_paths.size
  end

  def quiz_2
    @part = :part_2
    @possible_paths = []

    dfs('start', [], Hash.new(0))

    possible_paths.size
  end

  def dfs(node, history, small_cave_visits)
    history << node

    small_cave_visits[node] += 1 if small_cave?(node)

    children = connections[node].reject do |child_node|
      skip_node?(child_node, small_cave_visits)
    end

    possible_paths << history if children.empty? && node == 'end'

    children.each do |child|
      dfs(child, history.dup, small_cave_visits.dup)
    end
  end

  def initialize_nodes
    @nodes = pairs.flatten.uniq
  end

  def skip_node?(node, small_cave_visits)
    return false unless small_cave?(node)

    case part
    when :part_1
      small_cave_visits[node] >= 1
    when :part_2
      small_cave_visits[node] > 1 ||
        (small_cave_visits[node] == 1 &&
         small_cave_visits.any? { |_, v| v > 1 })
    end
  end

  def initialize_connections
    @connections = Hash.new { |h, k| h[k] = [] }

    nodes.each do |node|
      next if node == 'end'

      pairs.select { |pair| pair.include?(node) }.each do |pair|
        adjacent = find_adjacent(node, pair)

        connections[node] << adjacent if adjacent
      end
    end

    @connections.transform_values!(&:sort)
  end

  def find_adjacent(node, pair)
    pair.find do |pair_node|
      pair_node != node && pair_node != 'start'
    end
  end

  def downcase?(string)
    /^[a-z]+$/.match(string)
  end

  def small_cave?(node)
    !%w[start end].include?(node) && downcase?(node)
  end
end

p Solution.new('input.txt').quiz_1
p Solution.new('input.txt').quiz_2
