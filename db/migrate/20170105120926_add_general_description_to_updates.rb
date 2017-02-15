class AddGeneralDescriptionToUpdates < ActiveRecord::Migration[5.0]
  def change
    add_column :updates, :general_description, :text
  end
end
