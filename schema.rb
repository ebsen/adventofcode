require 'sequel'
require 'sqlite3'

def init_db
  DB.create_table :advent do
    primary_key   :id
    Integer       :day,     null: false, unique: true
    String        :input
    Integer       :solution1
    Integer       :solution2
  end

  # records = DB.from :advent
  DB.from :advent
end
