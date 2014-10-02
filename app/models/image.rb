class Image < ActiveRecord::Base
  validates :element, presence: true
  validates :element_id, presence: true
  has_attached_file :image,
      :url => "/upload/profile/:id/:basename.:extension",
      :path => ":rails_root/public/upload/profile/:id/:basename.:extension",
      :default_url => "98fa08826a289061287081c67c10f7bc.jpg"
  validates_attachment_content_type :image, :content_type => /\Aimage/
  validates_attachment_file_name :image, :matches => [/gif\Z/, /jpe?g\Z/]

  def self.profile_picture(user)
    find_by(element: "user", element_id: user.id)
  end
end