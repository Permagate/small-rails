class Story < ActiveRecord::Base

  belongs_to :user
  has_many :comments, -> { order(created_at: :desc) }
  has_many :likes, as: :likeable

  validates :body, presence: true
  validates :title, presence: true
  validates :user, presence: true

  scope :latest, -> { order(created_at: :desc) }
  scope :owned_by, -> (user) { where(user: user) }

  def like(user)
    self.likes.build(user_id: user.id).save
  end

end
