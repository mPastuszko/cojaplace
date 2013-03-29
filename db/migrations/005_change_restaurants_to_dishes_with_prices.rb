# encoding: UTF-8

migration "Change restaurants to dishes with prices" do
  database.create_table :dishes do
    text :restaurant, :null => false
    text :dish, :null => false
    float :price, :null => false
  end
  database.drop_table :restaurants
end
