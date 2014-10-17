class User < ActiveRecord::Base

  state_machine :initial => :inactive do
    state :inactive, value: false
    state :active, value: true

    event :activate do
      transition :inactive => :active
    end

    event :inactivate do
      transition :active => :inactive
    end
  end

  has_many :microposts, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id",
           class_name: "Relationship",
           dependent: :destroy
  has_many :followers, through: :reverse_relationships, source: :follower
  has_one :image, through: :user_image
  before_save { self.email = email.downcase }
  before_create :create_remember_token
  validates :name, presence: true, length: {maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
            format: {with: VALID_EMAIL_REGEX},
            uniqueness: {case_sensitive: false}
  has_secure_password :validations => false
  validates :password, length: {minimum: 6}

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def sign_up_token
    return User.new_remember_token
  end

  def User.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def feed
    Micropost.from_users_followed_by(self)
  end

  def following?(other_user)
    relationships.find_by(followed_id: other_user.id)
  end

  def follow(other_user)
    relationships.create(followed_id: other_user.id)
  end
  def unfollow(other_user)
    relationships.find_by(followed_id: other_user.id).destroy
  end


  def unfollow!(other_user)
    relationships.find_by(followed_id: other_user.id).destroy
  end

  def send_password_reset
    self.password_reset_sent_at = Time.zone.now
    self.password_reset_token = sign_up_token
    # binding.pry
    save!(:validate => false)
  end

  private

  def create_remember_token
    self.remember_token = User.digest(User.new_remember_token)
  end
end