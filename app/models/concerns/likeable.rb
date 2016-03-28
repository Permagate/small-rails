module Likeable
  extend ActiveSupport::Concern

  included do
    has_many :likes, as: :likeable
  end

  def like(user)
    self.likes.build(user_id: user.id).save
  end
end
