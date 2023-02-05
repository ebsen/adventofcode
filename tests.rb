require 'test/unit'

require_relative 'solutions'

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
#
#   def test_day3
#     p1, p2 = @@solutions.for day: 3
#     assert_equal nil, p1
#     assert_equal nil, p2
#   end
end
