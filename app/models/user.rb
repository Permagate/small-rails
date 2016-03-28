class User < ActiveRecord::Base

  devise :database_authenticatable, :recoverable, :validatable
  after_create :generate_access_token

  def generate_access_token
    loop do
      self.access_token = "#{self.id}:#{Devise.friendly_token}"
      break unless User.where(access_token: self.access_token).first
    end
    self.save
  end

end
