class Message < ActiveRecord::Base

  belongs_to :user
  validates :content, presence: true, length: { maximum: 140 }
  validates :user_id, presence: true
  validates :sender_id, presence: true

  # def self.get_receiver(user)
  #   receiver_id = "SELECT receiver FROM messages
  #                        WHERE receiver = :user_id"
  #   where("user_id IN (#{receiver_id}) OR user_id = :user_id",
  #         user_id: user.id)
  # end
end
