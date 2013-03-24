# encoding: UTF-8

migration "Create order items" do
  database.create_table :order_items do
    text :date, :null => false
    text :user, :null => false
    text :dish, :null => false
    double :price, :null => false
    text :notes, :null => false, :default => ''
  end
end
