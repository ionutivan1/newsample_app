class CreateImage < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :type
      t.integer :element_id
    end
  end
end
