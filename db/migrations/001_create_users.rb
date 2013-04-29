# encoding: UTF-8

migration "Create users" do
 database.create_table :users do
   text :name, :primary_key => true, :unique => true, :null => false
 end
end
