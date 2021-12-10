# frozen_string_literal: true

class Solution
  attr_reader :lines, :pairs, :illegal_score, :missing_score

  def initialize(filename)
    @lines = File.read(filename).split("\n").map(&:chars)
    @pairs = {
      '(' => ')',
      '[' => ']',
      '{' => '}',
      '<' => '>'
    }

    @illegal_score = {
      ')' => 3,
      ']' => 57,
      '}' => 1_197,
      '>' => 25_137
    }

    @missing_score = {
      ')' => 1,
      ']' => 2,
      '}' => 3,
      '>' => 4
    }
  end

  def quiz_1
    lines.map { |line| analyze(line) }
         .select { |(status, _res)| status == :illegal }
         .map { |(_status, illegal_char)| illegal_score[illegal_char] }.sum
  end

  def quiz_2
    scores = lines.map { |line| analyze(line) }
                  .select { |(status, _res)| status == :incompleted }
                  .map { |(_status, missing)| calculate_score(missing) }

    scores.sort[scores.length / 2]
  end

  def analyze(line)
    illegal = nil

    stack = []

    line.each do |char|
      if pairs[char]
        stack.push(char)
      else
        expected = pairs[stack.pop]

        if expected != char
          illegal = char

          break
        end
      end
    end

    return [:illegal, illegal] if illegal
    return [:incompleted, stack.reverse.map { |char| pairs[char] }] unless stack.empty?

    [:success, nil]
  end

  def calculate_score(chars)
    sum = 0
    chars.each do |char|
      sum = sum * 5 + missing_score[char]
    end

    sum
  end
end

p Solution.new('input.txt').quiz_1
p Solution.new('input.txt').quiz_2
