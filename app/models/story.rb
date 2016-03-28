class Story < ActiveRecord::Base

  belongs_to :user
  has_many :comments, -> { order(created_at: :desc) }

  scope :latest, ->(n) { order(created_at: :desc).limit(n) }
  scope :owned_by, ->(user) { where(user: user) }

end
