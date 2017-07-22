class ModifyDefaultsOnRelationshipTable < ActiveRecord::Migration[5.1]
  def change
    change_column :relationships, :friends, :boolean, :default => false, :null => false
    change_column :relationships, :block, :boolean, :default => false, :null => false
    change_column :relationships, :subscribe, :boolean, :default => false, :null => false
  end
end
