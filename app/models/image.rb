class Image < ActiveRecord::Base
  validates :element, presence: true
  validates :element_id, presence: true
  has_attached_file :image
  validates_attachment_content_type :image, :content_type => /\Aimage/
  validates_attachment_file_name :image, :matches => [/gif\Z/, /jpe?g\Z/]
end