class CreateRelationships < ActiveRecord::Migration[5.1]
  def change
    create_table :relationships do |t|
      t.references :user, foreign_key: true
      t.integer :target_user_id
      t.boolean :friends
      t.boolean :block

      t.timestamps
    end
  end
end
