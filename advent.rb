#!/usr/bin/env ruby

# The main entry point via CLI
# for 2022 Advent of Code in Ruby.

require 'net/http'
require 'optparse'

require 'sequel'
require 'sqlite3'

require_relative 'solutions'
require_relative 'schema'

options = { :debug => false, :init => false }
OptionParser.new do |opt|
  opt.on('--debug', 'Enable debugging')    { options[:debug] = true }
  opt.on('--init',  'Initialize database') { options[:init]  = true }
  opt.on('--migrate',  'Migrate database') { options[:migrate]  = true }
end.parse!
puts options if options[:debug]

DB = Sequel.connect('sqlite://advent.db')
init if options[:init]
if options[:migrate]
  migrate
  exit
end

solutions = Solutions.new
answers = DB.from(:answers)
DB.from(:inputs).order(:day).each do |input|
  # Destruct the record with pattern matching and rightward assignment!
  input => {id: input_id, day:, input: input_text}
  puts "\nResults for day #{day}:"
  # Try to solve every puzzle for which we have a solution implemented.
  solutions.for(day: day, input: input_text).each_with_index do |result, index|
    answer = answers.where(input_id: input_id, part: index + 1).get(:answer)
    if answer.nil?
      output = "  #{result}" # "(new)"
      # TODO: Insert result as answer
    elsif result == answer
      output = "✔ #{result}"
    else
      output = "✗ #{result} (#{answer})"
    end
    puts output
  end
end
