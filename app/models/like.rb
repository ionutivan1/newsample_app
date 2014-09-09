class Like < ActiveRecord::Base
  belongs_to :micropost
  validates_presence_of :liker_id, presence: true
  validates_presence_of :micropost_id, presence: true
end