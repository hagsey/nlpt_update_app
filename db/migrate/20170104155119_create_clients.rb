class CreateClients < ActiveRecord::Migration[5.0]
  def change
    create_table :clients do |t|
      t.string :first_name
      t.string :last_name
      t.datetime :date_of_birth
      t.string :program

      t.timestamps
    end
  end
end
