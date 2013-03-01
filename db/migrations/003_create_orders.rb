# encoding: UTF-8

migration "Create orders" do
  database.create_table :orders do
    text :date, :primary_key => true, :uniq => true, :null => false
    text :restaurant, :null => false, :default => ''
    text :payer
  end
end
