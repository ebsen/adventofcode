require 'sequel'
require 'sqlite3'


# DB = Sequel.connect('sqlite://advent.db')
def init_db
  DB.create_table :advent do
    # id, day, input, solution, part, type
    primary_key   :id
    Integer       :day,     null: false, unique: true
    String        :input #, null: true  # TODO: String? Text?
    Integer       :solution1#, null: false
    Integer       :solution2#, null: false
    # Integer       :part,     null: false
    # Integer       :type,     null: false  # 1 for sample, 2 for "real"
  end

  records = DB.from :advent
  # (1..25).each do |day|
  # records.insert :day 1, :input
end
