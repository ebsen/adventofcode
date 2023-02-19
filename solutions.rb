require 'set'

class Solutions
  @@is_debug = false

  def for day: nil, input: nil
    # Get (a little) clever and dynamically call the correct `day<#>` method.
    part1, part2 = self.send "day#{day}".to_sym, input
    return part1, part2
  end

  private
  def process data, as_i: false
    # `data` is a multiline string.
    data.split("\n").map {|l| as_i ? l.to_i : l.chomp}
  end

  def day1 input
    calories = 0
    totals = []
    process(input, as_i: true).each do |line|
      if line.zero?
        totals.push calories unless calories.zero?
        calories = 0
      else
        calories += line
      end
    end
    return totals.max, totals.sort.reverse.take(3).sum
  end

  def day2 strategy_guide
    # Rock defeats Scissors, Scissors defeats Paper, and Paper defeats Rock.
    #   A = rock
    #   B = paper
    #   C = scissors
    p1_score, p2_score = 0, 0
    opponent_choice_cypher = {'A' => :rock, 'B' => :paper, 'C' => :scissors,}
    your_choice_cypher =     {'X' => :rock, 'Y' => :paper, 'Z' => :scissors,}
    result_choice_cypher =   {'X' => :loss, 'Y' => :draw,  'Z' => :win,}
    points = {
      :rock => 1, :paper => 2, :scissors => 3,
      :loss => 0, :draw =>  3, :win =>      6,
    }
    def compare theirs, yours
      # Pattern matching is neat! This, however, is pretty ugly.
      case [theirs, yours]
      in [:rock, :scissors] | [:scissors, :paper] | [:paper, :rock]
        result = :loss
      in [:scissors, :rock] | [:paper, :scissors] | [:rock, :paper]
        result = :win
      in [:rock, :rock] | [:paper, :paper] | [:scissors, :scissors]
        result = :draw
      in [choice, :win]
        case choice
        in :rock
          result = :paper
        in :paper
          result = :scissors
        in :scissors
          result = :rock
        end
      in [choice, :loss]
        case choice
        in :rock
          result = :scissors
        in :paper
          result = :rock
        in :scissors
          result = :paper
        end
      in [choice, :draw]
        result = choice
      end
      result
    end

    process(strategy_guide).each do |line|
      theirs, yours = line.split(' ')
      p1_score +=
        points[your_choice_cypher[yours]] +
        points[compare(
          opponent_choice_cypher[theirs], your_choice_cypher[yours]
        )]
      p2_score +=
        points[result_choice_cypher[yours]] +
        points[compare(
          opponent_choice_cypher[theirs], result_choice_cypher[yours]
        )]
    end
    return p1_score, p2_score
  end

  def day3 rucksacks
    def priority char
      1 + ((('a'..'z').to_a + ('A'..'Z').to_a).index char)
    end

    # Part 1
    p1_sum_priorities = 0
    process(rucksacks).each do |contents|
      first = contents[0, contents.size / 2]
      second = contents[contents.size / 2, contents.size]
      common_char = (first.chars & second.chars).first
      x = priority common_char
      p1_sum_priorities += x
    end

    # Part 2
    p2_sum_priorities = 0
    process(rucksacks).each_slice(3).each do |group|
      badge = (group[0].chars & group[1].chars & group[2].chars).first
      p2_sum_priorities += priority badge
    end
    return p1_sum_priorities, p2_sum_priorities
  end

  def day4 section_assignments
    # Find the pairs in which one set completely contains the other.
    overlaps = process(section_assignments).select do |pair|
      left, right = pair.split(",").map do |side|
        first, last = side.split("-").map {|e| e.to_i }
        first..last
      end
      (left.cover? right) or (right.cover? left)
    end
    return overlaps.size, 0
  end
end
