class Micropost < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order('created_at DESC') }
  validates :content, presence: true, length: {maximum: 140}
  validates :user_id, presence: true

  has_many :likes, foreign_key: "micropost_id", dependent: :destroy
  has_many :likers, through: :likes, source: :micropost
  has_many :reverse_relationships, foreign_key: "liker_id",
           class_name: "Like",
           dependent: :destroy

  # Returns microposts from the users being followed by the given user.
  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id",
          user_id: user.id)
  end

  def liking?(user)
    likes.find_by(liker_id: user.id)
  end

  def like(micropost, user)
    likes.create(liker_id: user.id, micropost_id: micropost.id)
  end

  def unlike(micropost,user)
    likes.find_by(liker_id: user.id,micropost_id: micropost.id).destroy
  end
end
