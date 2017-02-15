class AddLowerIndexesToClients < ActiveRecord::Migration[5.0]
  def up
    execute %{
      CREATE INDEX 
      clients_lower_last_name
      ON
      clients (lower(last_name) varchar_pattern_ops)
    }
    execute %{
      CREATE INDEX 
      clients_lower_first_name
      ON
      clients (lower(first_name) varchar_pattern_ops)
    }
  end

  def down
    remove_index :clients, name: 'clients_lower_last_name'
    remove_index :clients, name: 'clients_lower_first_name'
  end
end
