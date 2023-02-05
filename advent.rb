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
end.parse!
puts options if options[:debug]

DB = Sequel.connect('sqlite://advent.db')
if options[:init]
  init_db
end

puts "Starting..."
solutions = Solutions.new
records = DB.from(:advent).order(:day).select(:day, :input)
# puts "Done. Nothing found." if records.nil?
records.each do |r|
  day = r[:day]
  puts "Found no data." if r.nil?
  begin
    p1, p2 = solutions.for day: day, input: r[:input]
  rescue NoMethodError
    puts "No method for day#{day}. Done."
    break
  end
  puts "\nResults for day #{day}:"
  p p1
  p p2
end
