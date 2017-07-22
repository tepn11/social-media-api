class AddSubscribeToRelationshipTable < ActiveRecord::Migration[5.1]
  def change
    add_column :relationships, :subscribe, :boolean, :default => false
  end
end
