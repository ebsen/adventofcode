class Solutions
  @@is_debug = false

  def for day: nil, input: nil
    # if day.nil? or input.nil?
    #   puts "Failwhale..."
    #   return nil, nil
    # end

    # Get (a little) clever and dynamically call the correct `day<#>` method.
    part1, part2 = self.send "day#{day}".to_sym, input
    return part1, part2
  end

  private
  def process data, as_i: true
    # `data` is a multiline string.
    data.split("\n").map {|l| as_i ? l.to_i : l.chomp}
  end

  def day1 input
    # p input.first 10
    calories = 0
    totals = []
    process(input).each do |line|
      # p line
      if line.zero?
        # i = totals.index {|t| t >= line} || -1
        # totals.insert(i, calories) unless calories.zero?
        totals.push calories unless calories.zero?
        calories = 0
      else
        calories += line
      end
    end
    # p totals
    return totals.max, totals.sort.reverse.take(3).sum
  end

  def day2 strategy_guide
    # Rock defeats Scissors, Scissors defeats Paper, and Paper defeats Rock.
    # Guesses: 6795 (too low), 9708 (too low)
    # p strategy_guide if @@is_debug
    p1_cypher = {
      # :rock => ['A', 'X'], :paper => ['B', 'Y'], :scissors => ['C', 'Z'],
      # 'A' => :rock,
      # 'B' => :paper,
      # 'C' => :scissors,
      'X' => :rock,
      'Y' => :paper,
      'Z' => :scissors,
    }
    # p1_choices = { 'X' => :rock, 'Y' => :paper, 'Z' => :scissors }
    p2_cypher = {
      'A' => :rock, 'B' => :paper, 'C' => :scissors,
      'X' => :loss, 'Y' => :draw,  'Z' => :win,
    }
    points = {
      :rock => 1, :paper => 2, :scissors => 3,
      :loss => 0, :draw =>  3, :win =>      6,
    }
    p1_score = 0
    p2_score = 0
    # p strategy_guide
    process(strategy_guide, as_i: false).each do |line|
      opponent_choice, your_choice = line.split(' ')
      # points_for_outcome = 0
      case [opponent_choice, your_choice]
      in ['A', 'Y'] | ['B', 'Z'] | ['C', 'X']
        p1_score += points[:win]
        p2_score += points[:draw]
      in ['A', 'Z'] | ['B', 'X'] | ['C', 'Y']
        p1_score += points[:loss]
        p2_score += points[:loss]
        # p2_score
      in ['A', 'X'] | ['B', 'Y'] | ['C', 'Z']
        p1_score += points[:draw]
        p2_score += points[:win]
      else
        puts "No match! #{opponent_choice} #{your_choice}"
      end
      p1_score += points[p1_cypher[your_choice]] #+ points_for_outcome
      p2_score += points[p2_cypher[opponent_choice]]
      # p2_score += points[p2_choices[your_choice]] #+ points[p2_choices[your_choice]]
      # puts "#{opponent_choice} #{your_choice} | #{p1_score}: #{points[p1_cypher[your_choice]]} (#{cypher[your_choice]}) + #{points_for_outcome}"
      puts "#{opponent_choice} #{your_choice} | #{p2_score}:" # #{points[p2_cypher[opponent_choice]]} (#{cypher[your_choice]}) + #{points_for_outcome}"
    end
    return p1_score, p2_score
  end
end
