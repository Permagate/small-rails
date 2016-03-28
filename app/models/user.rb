class User < ActiveRecord::Base
  devise :database_authenticatable, :recoverable, :validatable

  has_many :likes

  after_create :update_access_token!

  private

  def update_access_token!
    self.access_token = generate_access_token
    save
  end

  def generate_access_token
    loop do
      token = "#{self.id}:#{Devise.friendly_token}"
      break token unless User.where(access_token: token).first
    end
  end
  
end
