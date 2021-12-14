# frozen_string_literal: true

class Solution
  attr_reader :formula, :replacement_hash, :pairs_count

  def initialize(filename)
    initial, replacements = File.read(filename).split("\n\n")

    @replacement_hash = replacements.split("\n")
                                    .map { |inst| inst.split(' -> ') }
                                    .to_h.transform_keys(&:chars)

    @formula = initial.chars
  end

  def quiz_1
    10.times do
      @formula = calculate_new_formula
    end

    p score
  end

  def quiz_2
    @pairs_count = Hash.new(0)

    formula.each_cons(2).each { |pair| pairs_count[pair] += 1 }

    40.times do
      calculate_pairs_count
    end

    p score_from_pairs
  end

  def calculate_new_formula
    new_formula = []

    formula.each_cons(2).with_index do |pair, index|
      next if replacement_hash[pair].nil?

      new_formula += if index.zero?
                       [pair.first, replacement_hash[pair], pair.last]
                     else
                       [replacement_hash[pair], pair.last]
                     end
    end

    new_formula
  end

  def score
    quantities = formula.group_by(&:itself)
                        .transform_values(&:size).sort_by { |_, v| -v }

    [quantities[0], quantities[-1]].map(&:last).inject(:-)
  end

  def calculate_pairs_count
    new_pairs_count = pairs_count.dup

    pairs_count.each do |(pair, count)|
      new_letter = replacement_hash[pair]

      new_pairs = [[pair.first, new_letter], [new_letter, pair.last]]

      new_pairs_count[pair] -= count
      new_pairs.each do |new_pair|
        new_pairs_count[new_pair] += count
      end
    end

    @pairs_count = new_pairs_count
  end

  def score_from_pairs
    letters_count = Hash.new(0)

    letters_count[formula.first] += 1

    pairs_count.each do |(_, letter2), count|
      letters_count[letter2] += count
    end

    quantities = letters_count.sort_by { |_, v| -v }

    [quantities[0], quantities[-1]].map(&:last).inject(:-)
  end
end

Solution.new('input.txt').quiz_1
Solution.new('input.txt').quiz_2
