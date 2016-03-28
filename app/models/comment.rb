class Comment < ActiveRecord::Base

  belongs_to :story
  belongs_to :user
  has_many :likes, as: :likeable

  validates :content, presence: true
  validates :user, presence: true
  validates :story, presence: true

  scope :latest, -> { order(created_at: :desc) }
  scope :owned_by, -> (user) { where(user: user) }

  def like(user)
    self.likes.build(user_id: user.id).save
  end

end
