class Comment < ActiveRecord::Base
  include Likeable

  belongs_to :story
  belongs_to :user

  validates :content, presence: true
  validates :user, presence: true
  validates :story, presence: true

  scope :latest, -> { order(created_at: :desc) }
  scope :owned_by, -> (user) { where(user: user) }

end
