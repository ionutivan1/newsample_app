class Message < ActiveRecord::Base

  belongs_to :user
  has_attached_file :mes_attach,
    :url => "/upload/:id/:basename.:extension",
    :path => ":rails_root/public/upload/:id/:basename.:extension"
  validates :content, presence: true, length: {maximum: 140}
  validates :user_id, :presence => { :message => " does not exist; please input another address" }
  validates :sender_id, presence: true
  validates_attachment_content_type :mes_attach, :content_type => /\Aimage/
  validates_attachment_file_name :mes_attach, :matches => [/gif\Z/, /jpe?g\Z/]

end
