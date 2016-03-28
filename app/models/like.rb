class Like < ActiveRecord::Base
  belongs_to :likeable, polymorphic: true
  has_one :user

  #validates :user, :uniqueness => {scope: :likeable}
end
