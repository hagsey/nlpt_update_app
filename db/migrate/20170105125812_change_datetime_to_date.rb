class ChangeDatetimeToDate < ActiveRecord::Migration[5.0]
  def change
    change_column :updates, :date, :date
  end
end
