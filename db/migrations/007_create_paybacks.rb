# encoding: UTF-8

migration "Create paybacks" do
  database.create_table :paybacks do
    text :date, :null => false
    text :payer, :null => false
    text :receiver, :null => false
    float :amount, :null => false
  end
end
