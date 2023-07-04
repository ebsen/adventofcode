require 'test/unit'

require_relative '../src/solutions'

class SolutionsTests < Test::Unit::TestCase
  # A test for the sample inputs for each's days' puzzle.
  # assert_equal expected, actual
  @@solutions = Solutions.new

  def test_day1
    # HEREDOC syntax didn't work here. Too lazy to go back and figure out why.
    input = %{
      1000
      2000
      3000

      4000

      5000
      6000

      7000
      8000
      9000

      10000
    }
    p1, p2 = @@solutions.for day: 1, input: input
    assert_equal 24000, p1
    assert_equal 45000, p2
  end

  def test_day2
    input = <<~HEREDOC
      A Y
      B X
      C Z
    HEREDOC
    p1, p2 = @@solutions.for day: 2, input: input
    assert_equal 15, p1
    assert_equal 12, p2
  end

  def test_day3
    input = <<~HEREDOC
      vJrwpWtwJgWrhcsFMMfFFhFp
      jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
      PmmdzqPrVvPwwTWBwg
      wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
      ttgJtRGJQctTZtZT
      CrZsJsPPZsGzwwsLwLmpwMDw
    HEREDOC
    p1, p2 = @@solutions.for day: 3, input: input
    assert_equal 157, p1
    assert_equal 70, p2
  end

  def test_day4
    input = <<~HEREDOC
      2-4,6-8
      2-3,4-5
      5-7,7-9
      2-8,3-7
      6-6,4-6
      2-6,4-8
    HEREDOC
    p1, p2 = @@solutions.for day: 4, input: input
    assert_equal 2, p1
    assert_equal 4, p2
  end

  def test_day5
    input = <<~HEREDOC
          [D]
      [N] [C]
      [Z] [M] [P]
       1   2   3

      move 1 from 2 to 1
      move 3 from 1 to 3
      move 2 from 2 to 1
      move 1 from 1 to 2
    HEREDOC
    p1, p2 = @@solutions.for day: 5, input: input
    assert_equal "CMZ", p1
    assert_equal "MCD", p2
  end

  def test_day6
    def results input
      @@solutions.for day: 6, input: input
    end

    input1 = "mjqjpqmgbljsphdztnvjfqwrcgsmlb"
    input2 = "bvwbjplbgvbhsrlpgdmjqwftvncz"
    input3 = "nppdvjthqldpwncqszvftbrmjlhg"
    input4 = "nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg"
    input5 = "zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw"

    assert_equal [7, 19], results(input1)
    assert_equal [5, 23], results(input2)
    assert_equal [6, 23], results(input3)
    assert_equal [10, 29], results(input4)
    assert_equal [11, 26], results(input5)
  end

  def test_day7
    input = <<~HEREDOC
      $ cd /
      $ ls
      dir a
      14848514 b.txt
      8504156 c.dat
      dir d
      $ cd a
      $ ls
      dir e
      29116 f
      2557 g
      62596 h.lst
      $ cd e
      $ ls
      584 i
      $ cd ..
      $ cd ..
      $ cd d
      $ ls
      4060174 j
      8033020 d.log
      5626152 d.ext
      7214296 k
    HEREDOC

    # Unused in the end.
    filesystem = <<~HEREDOC
      - / (dir)
        - a (dir)
          - e (dir)
            - i (file, size=584)
          - f (file, size=29116)
          - g (file, size=2557)
          - h.lst (file, size=62596)
        - b.txt (file, size=14848514)
        - c.dat (file, size=8504156)
        - d (dir)
          - j (file, size=4060174)
          - d.log (file, size=8033020)
          - d.ext (file, size=5626152)
          - k (file, size=7214296)
    HEREDOC

    p1, p2 = @@solutions.for day: 7, input: input
    assert_equal 95437, p1
    assert_equal 24933642, p2
  end
end
