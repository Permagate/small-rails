class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.integer :user_id
      t.integer :likeable_id
      t.string  :likeable_type
      t.timestamps null: false
    end

    add_index :likes, [:user_id, :likeable_id], unique: true
  end
end
