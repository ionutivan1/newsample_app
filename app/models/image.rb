class Image < ActiveRecord::Base
  validates :element, presence: true
  validates :element_id, presence: true
  has_attached_file :image,
      :url => "/upload/profile/:id/:basename.:extension",
      :path => ":rails_root/public/upload/profile/:id/:basename.:extension"
  validates_attachment_content_type :image, :content_type => /\Aimage/
  validates_attachment_file_name :image, :matches => [/gif\Z/, /jpe?g\Z/]
end