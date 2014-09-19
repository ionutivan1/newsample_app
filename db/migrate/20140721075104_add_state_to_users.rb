class AddStateToUsers < ActiveRecord::Migration
  def change
    add_column :users, :state, :boolean, default: false
    add_column :users, :confirmation, :string
  end
end
