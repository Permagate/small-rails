# app/controllers/v1/sessions_controller.rb
module V1
  class SessionsController < ApplicationController
    # POST /v1/login
    def create
      @user = User.find_for_database_authentication(email: params[:email])

      if @user.valid_password?(params[:password])
        sign_in :user, @user
        render json: @user, serializer: SessionSerializer, root: nil
      else
        render json: { error: 'Invalid password!' }
      end
    end
  end
end
