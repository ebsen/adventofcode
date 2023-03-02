#!/usr/bin/env ruby

# The main entry point via CLI
# for 2022 Advent of Code in Ruby.

require 'net/http'
require 'optparse'
require 'sqlite3'

require 'sequel'

require_relative 'models'
require_relative 'schema'
require_relative 'solutions'

options = { :debug => false, :init => false }
OptionParser.new do |opt|
  opt.on('--debug',   'Enable debugging')    { options[:debug]   = true }
  opt.on('--init',    'Initialize database') { options[:init]    = true }
  opt.on('--migrate', 'Migrate database')    { options[:migrate] = true }
end.parse!
puts options if options[:debug]
init if options[:init]
migrate if options[:migrate]

def output result, answer
  result = result.to_s
  if answer.nil?
    # New result, no known answer.
    result.prepend "? "
    # TODO: Insert result as answer.
  elsif result == answer
    result.prepend "✔ "
  else
    result = "✗ #{result} (#{answer})"
  end
  puts result
end

# Actually do the thing.
solutions = Solutions.new
Input.order(:day).each do |input|
  # Destruct the record with pattern matching and rightward assignment!
  input.values => {id: input_id, day:, input: input_text}
  puts "\n  Day #{day}"
  puts "----------"

  # Try to solve both puzzles for this input.
  solutions.for(day: day, input: input_text).each_with_index do |result, index|
    answer = Answer.where(input_id: input_id, part: index + 1).get(:answer)
    output result, answer
  end
end
