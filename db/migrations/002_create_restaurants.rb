# encoding: UTF-8

migration "Create restaurants" do
  database.create_table :restaurants do
    text :name, :primary_key => true, :unique => true, :null => false
  end
end
