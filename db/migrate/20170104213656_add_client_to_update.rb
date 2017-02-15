class AddClientToUpdate < ActiveRecord::Migration[5.0]
  def change
    add_column :updates, :client_id, :integer
  end
end
