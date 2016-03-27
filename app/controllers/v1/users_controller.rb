module V1
  class UsersController < ApplicationController
    # POST /v1/users
    # Creates an user
    def create
      @user = User.new user_params
      @user.save
      loop do
        @user.access_token = "#{@user.id}:#{Devise.friendly_token}"
        break unless User.where(access_token: @user.access_token).first
      end
      @user.save
      render json: @user, serializer: V1::SessionSerializer, root: nil
    end

    private

    def user_params
      params.require(:user).permit(:email, :username, :password, :password_confirmation)
    end
  end
end
