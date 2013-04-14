# encoding: UTF-8

migration "Add payment to order" do
  database.alter_table :orders do
    add_column :paid, :float
  end
end
