class Message < ActiveRecord::Base

  belongs_to :user
  validates :content, presence: true, length: { maximum: 140 }
  validates :user_id, presence: true
  validates :sender_id, presence: true

end
