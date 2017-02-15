class RemoveDateFromUpdates < ActiveRecord::Migration[5.0]
  def change
    remove_column :updates, :date, :datetime
  end
end
