class AddCoachNameToUpdates < ActiveRecord::Migration[5.0]
  def change
    add_column :updates, :coach_name, :string
  end
end
