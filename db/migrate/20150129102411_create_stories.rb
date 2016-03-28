class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.string :title, null: false
      t.text :body, null: false
      t.belongs_to :user, index: true
      
      t.timestamps null: false
    end
  end
end
