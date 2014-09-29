class Image < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :element
      t.integer :element_id

      t.timestamps
    end
  end
end
