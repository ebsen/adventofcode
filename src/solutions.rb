require 'matrix'
require 'set'

class Node
  attr_accessor :name
  attr_accessor :parent
  attr_accessor :size

  def initialize(name: "/", parent: nil)
    @name = name
    @parent = parent
    @size = 0
  end
end


class Solutions
  @@is_debug = false

  def for day: nil, input: nil
    # Get (a little) clever and dynamically call the correct `day<#>` method.
    solver = "day#{day}".to_sym
    begin
      part1, part2 = self.send solver, input
    rescue NoMethodError
      puts "No implementation found for day #{day}."
      part1, part2 = nil, nil
    end
    return part1, part2
  end

  private

  def process data, as_i: false
    # `data` is a multiline string.
    data.split("\n").map do |line|
      if as_i
        line.to_i
      else
        line.chomp
      end
    end
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
    # Part 1: Find the pairs in which one set completely contains the other.
    overlap_totally = process(section_assignments).select do |pair|
      left, right = pair.split(",").map do |side|
        first, last = side.split("-").map {|e| e.to_i }
        first..last
      end
      (left.cover? right) or (right.cover? left)
    end

    # Part 2: Find the pairs in which either set overlaps the other at all.
    overlaps = process(section_assignments).select do |pair|
      left, right = pair.split(",").map do |side|
        l, r = side.split("-").map {|s| s.to_i}
        (l..r).to_a
      end
    !(left & right).empty?
    end
    return overlap_totally.size, overlaps.size
  end

  def day5 drawing
    stacks1 = {}
    stacks2 = {}
    crates, procedure = drawing.split("\n\n").map {|half| half.split("\n")}
    col_line = crates.pop
    # Build out starting stack positions.
    (1..col_line.split(" ").last.to_i).each do |column|
      stacks1[column] = []
      stacks2[column] = []
      idx = col_line.index column.to_s
      crates.reverse.each do |row|
        crate = row[idx]
        [stacks1, stacks2].each do |stacks|
          stacks[column].push row[idx] unless crate.nil? or crate.match? /\s/
        end
      end
    end

    # Follow the procedure on the bottom half of the drawing.
    procedure.each do |step|
      quantity, origin, destination = step
        .split(" ")
        .map {|x| x.to_i}
        .select {|x| x.nonzero?}
      # Part 1
      quantity.times {stacks1[destination].push(stacks1[origin].pop)}
      # Part 2
      stack = stacks2[origin].slice!(-quantity, quantity)
      stacks2[destination].push *stack
    end

    return [stacks1, stacks2].map {|stack| stack.map {|_, s| s.last}.join}
  end

  def day6 buffer
    [4, 14].map { |len|
      buffer.chars.each_cons(len).select { |sequence|
        sequence == sequence.uniq
      }.first.join
    }.map { |sequence|
      # We want the last index of the sequence, not the first.
      (buffer.index sequence) + sequence.size
    }
  end

  def day7 text
    total_disk_size = 70_000_000
    space_needed = 30_000_000
    size_threshold = 100_000 # Part 1
    all_dirs = []
    current = nil
    filesystem = Node.new

    # Part 1
    # Process the tree.
    process(text).each do |line|
      next if line == "$ ls"
      case line.split(" ")
      in ["$", "cd", "/"]
        current = filesystem
        all_dirs.append current
      in ["$", "cd", ".."]
        current = current.parent
      in ["$", "cd", dir]
        new_dir = Node.new name: dir, parent: current
        all_dirs.append new_dir
        current = new_dir
      in ["dir", name]
        next
      in [size, filename]
        current.size += size.to_i
        going_up = current
        while going_up.parent
          going_up = going_up.parent
          going_up.size += size.to_i
        end
      end
    end

    p1_answer = all_dirs
      .filter {|dir| dir.size < size_threshold}
      .map {|dir| dir.size}
      .sum

    # Part 2
    # Find the directory to delete.
    needed_space_remaining = space_needed - (total_disk_size - filesystem.size)
    p2_answer = all_dirs
      .filter {|dir| dir.size > needed_space_remaining}
      .sort {|x, y| x.size <=> y.size}
      .reverse.last.size

    return [p1_answer, p2_answer]
  end

  def day8 map
    heights = Matrix[
      *map.split("\n").map do |line|
        line.split("").map(&:to_i)
      end
    ]
    visible_trees = 0
    highest_score = 0
    heights.each_with_index do |e, i, j|
      row   = heights.row i
      col   = heights.column j
      left  = row[...j]
      right = row[(j + 1)..]
      up    = col[...i ]
      down  = col[(i + 1)..]

      # Part 1: How many trees are visible from outside the grid?
      [left, right, up, down].each do |direction|
        is_visible = direction.to_a.all? {|d| d < e}
        if is_visible
          visible_trees += 1
          break
        end
      end

      # Part 2: Find the highest scenic scoring tree.
      score = [
        up.reverse,   # going outward from e this time
        left.reverse, # going outward from e this time
        down,
        right,
      ].map { |direction|
        distance = 0
        direction.each {|x|
          distance += 1
          break if e <= x
        }
        distance
      }.inject(&:*) # apply * to each mapped element
      highest_score = score if score > highest_score
    end
    [visible_trees, highest_score]
  end
end
