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
    String        :answer
    # Bool          :is_correct :TODO
  end

  DB.from :advent
end

def migrate1
  init
  old_records = DB.from(:advent).order(:day)
  inputs = DB.from(:inputs)
  answers = DB.from(:answers)
  old_records.each do |r|
    input_id = inputs.insert(day: r[:day], input: r[:input])
    answers.insert(input_id: input_id, part: 1, answer: r[:solution1])
    answers.insert(input_id: input_id, part: 2, answer: r[:solution2])
  end
  exit
end

def migrate2
  answers = DB[:answers]
  answers.insert(id: 1, input_id: 1, part: 1, answer: 66186)
  answers.insert(id: 2, input_id: 1, part: 2, answer: 196804)
  answers.insert(id: 3, input_id: 2, part: 1, answer: 12156)
  answers.insert(id: 4, input_id: 2, part: 2, answer: 10835)
  answers.insert(id: 5, input_id: 3, part: 1, answer: 8252)
  answers.insert(id: 6, input_id: 3, part: 2, answer: 2828)
  answers.insert(id: 7, input_id: 4, part: 1, answer: 580)
  answers.insert(id: 8, input_id: 4, part: 2, answer: 895)
  answers.insert(id: 9, input_id: 5, part: 1, answer: "ZWHVFWQWW")
  exit
end

def seed
  # TODO: Seed the database with known answers
end
