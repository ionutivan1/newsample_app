class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.integer :liker_id
      t.integer :micropost_id

      t.timestamps
    end
    add_index :likes, :liker_id
    add_index :likes, [:liker_id, :micropost_id], unique: true
  end
end
