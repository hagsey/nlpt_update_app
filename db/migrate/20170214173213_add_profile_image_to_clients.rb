class AddProfileImageToClients < ActiveRecord::Migration[5.0]
  def change
    add_column :clients, :profile_image, :string
  end
end
