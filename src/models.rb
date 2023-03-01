require 'sequel'

DB = Sequel.connect('sqlite://advent.db')

class Input < Sequel::Model
end

class Answer < Sequel::Model
  many_to_one :input
end
