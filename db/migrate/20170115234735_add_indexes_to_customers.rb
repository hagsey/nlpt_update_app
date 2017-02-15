class AddIndexesToCustomers < ActiveRecord::Migration[5.0]
  def change
    add_index :clients, :first_name
    add_index :clients, :last_name
  end
end
