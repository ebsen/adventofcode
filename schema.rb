require 'sequel'

def init
  DB.create_table :inputs do
    primary_key   :id
    Integer       :day,      null: false, unique: true
    String        :input
  end

  DB.create_table :answers do
    primary_key   :id
    # TODO:       FK to the input
    Integer       :input_id, null: false
    Integer       :part,     null: false
    Integer       :answer
    # Bool          :is_correct :TODO
  end

  DB.from :advent
end

def migrate
  init
  old_records = DB.from(:advent).order(:day)
  inputs = DB.from(:inputs)
  answers = DB.from(:answers)
  old_records.each do |r|
    input_id = inputs.insert(day: r[:day], input: r[:input])
    answers.insert(input_id: input_id, part: 1, answer: r[:solution1])
    answers.insert(input_id: input_id, part: 2, answer: r[:solution2])
  end
end

def seed
  # TODO: Seed the database with known answers
end
