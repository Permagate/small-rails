class Story < ActiveRecord::Base
  include Likeable

  belongs_to :user
  has_many :comments, -> { order(created_at: :desc) }

  validates :body, presence: true
  validates :title, presence: true
  validates :user, presence: true

  scope :latest, -> { order(created_at: :desc) }
  scope :owned_by, -> (user) { where(user: user) }

end
