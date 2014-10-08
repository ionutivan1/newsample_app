class Image < ActiveRecord::Base
  validates :element, presence: true
  validates :element_id, presence: true
  validates :image, :attachment_presence => true
  has_attached_file :image,
    :url => "/upload/:element/:id/:style/:basename.:extension",
    :styles => {
    :thumb => "50x50",
    :small => "150x150",
    :medium => "200x200",
    },
    :path => ":rails_root/public/upload/:element/:id/:style/:basename.:extension"
  validates_attachment_content_type :image, :content_type => /\Aimage/
  validates_attachment_file_name :image, :matches => [/gif\Z/, /jpe?g\Z/]

  Paperclip.interpolates :element do |image,style|
    image.instance.element
  end
  def self.profile_picture(user)
    find_by(element: "user", element_id: user.id)
  end
end