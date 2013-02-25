# encoding: UTF-8

migration "Create users" do
 database.create_table :users do
   text :name, :primary_key => true, :unique => true, :null => false
 end
 ['Daniel',
  'Grzesiek',
  'Łukasz',
  'Maciek',
  'Marcin J.',
  'Marcin O.',
  'Marcin T.',
  'Maurycy',
  'Mikołaj',
  'Piotrek',
  'Wojtek'].each do |name|
    database[:users].insert(name: name)
  end
end
