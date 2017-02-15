class AddGoalsToUpdates < ActiveRecord::Migration[5.0]
  def change
    add_column :updates, :goals, :text
  end
end
