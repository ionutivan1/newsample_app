class AddAttachmentMesAttachToMessages < ActiveRecord::Migration
  def self.up
    change_table :messages do |t|
      t.attachment :mes_attach
    end
  end

  def self.down
    remove_attachment :messages, :mes_attach
  end
end
