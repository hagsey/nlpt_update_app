class CreateUpdates < ActiveRecord::Migration[5.0]
  def change
    create_table :updates do |t|
      t.datetime :date
      t.text :comment
      t.integer :user_id
      t.text :health_status
      t.text :movement_limitations
      t.timestamps
    end
  end
end
