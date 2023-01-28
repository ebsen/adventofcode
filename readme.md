# Advent of Code

## 2022

Notes:
This year, Ruby!
A new branch containing _only_ 2022 code. Way simpler.

### Files
- tests.rb     -- Unit tests, written first.
- main.rb      -- Run a/each day's solver against real input data.
- solutions.rb -- Each day's solver function.
- init.rb      -- Initialize the database.
- data.sqlite  -- Store data.

### Main
- flags for year, debug, tests?
- tests (library? @todo)
- instead of a million text files, sqlite!
- Sequel gem? @todo

Check if we have the day's data. `DB[]`
If not, try to fetch it with a GET to the correct URL. Insert result.
If yes, solve it and print solution. If solutions aren't saved, add them.

If passed a single day, do the above once.
If not, iterate and do the above for each.


### Tests
Able to write tests first?
This wouldn't use the main script, instead calling each day's solve function directly.
Use sample data provided.

### Database
```ruby
# init
require 'sequel'
DB = Sequel.connect('sqlite://data.sqlite')
# clients (main, tests)
sample_data = DB.from(:advent).where(is_sample: true).order(:day)
day = 1
data = DB.from(:advent).where(day: day) # Can take arrays (where...in) , ranges: posts.where(stamp: (Date.today - 14)..(Date.today - 7))
data.select
data.exclude
data.insert
data.where().delete
data.where().update
data.where(id: 1).get(:input)
data.map([:day, :input, :solution, :part]) # [[1, 'abc', '42', '1'], [1, 'def', 99, 2]]
data.order(:day).each {|r| puts r[:solution]}
data.count # number of records
data.map(:id) # array of values for that column
data.all # `select * from advent`
data.first
```
```csv
advent
day,input,solution,part,is_sample
  1   abc       42    1
      def
  2   ...       99    2
```
How to store whether the input and solution are a sample or "real"

### Random
```ruby
options = {:debug => false, :test => false, :year => Date.today.year}
OptionParser.new do |opt|
  opt.on( '--day DAY', Integer, 'Only check a single day' ) { |o| options[:day] = o }
  opt.on('--debug', 'Enable debugging') { options[:debug] = true }
  opt.on('--test', 'Run the test suite') { options[:test] = true }
  opt.on('--year YEAR', Integer, "Define which year's tests to run") { |o| options[:year] = o }
end.parse!
puts options if options[:debug]
# input_data =
part1 = nil, part2 = nil
if day
  # part1, part2 = send "d#{day}", input_data
  part1, part2 = solve day, input_data
else
  (1..25).each do |day|
    part1, part2 = solve day, input_data
  end
end

def solve day data
  send "d#{day}", data
end
```

### Database
```ruby
require "sequel"
DB = Sequel.sqlite
DB.create_table :solutions do
  primary_key   :id
  Integer       :day,   null: false, unique: true
  Integer       :part1, null: true  # TODO: null true by default?
  Integer       :part2, null: true  # TODO: null true by default?
end
DB.create_table :inputs do
  primary_key   :id
  Integer       :day,   null: false, unique: true
  String        :part1, null: true  # TODO: String? Text?
  String        :part2, null: true  # TODO: String? Text?
end
```
```csv
-- outdated --
inputs
day,sample,real
```

---

## 2020

Solutions to [the 2020 Advent of Code](https://adventofcode.com/2020), written in Python.

## 2019

Solutions to [the 2019 Advent of Code](https://adventofcode.com/2019), written in Python.

## 2018

Solutions to [the 2018 Advent of Code](https://adventofcode.com/2018), written in Python.
