class Story < ActiveRecord::Base

  belongs_to :user
  has_many :comments, -> { order(created_at: :desc) }

end
