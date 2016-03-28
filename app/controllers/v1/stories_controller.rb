module V1
  class StoriesController < ApplicationController
    skip_before_action :authenticate_user_from_token!, only: [:index, :show]
    before_action :set_story, only: [:show, :update, :destroy]

    # GET /v1/stories
    def index
      @stories = Story.latest(30).all
      render json: @stories, each_serializer: StoriesSerializer
    end

    # GET /v1/stories/me
    def owned
      authenticate_user_from_token!
      @stories = Story.owned_by(current_user).latest(10)
      render json: @stories, each_serializer: StoriesSerializer
    end

    # POST /v1/stories
    def create
      @story = Story.new
      if @story.save
        render json: {}, status: :ok
      else
        render json: { error: @story.errors.full_messages }, status: :unprocessable_entity
      end
    end

    # GET /v1/stories/:id
    def show
      render json: @story, serializer: StorySerializer
    end

    # PUT /v1/stories/:id
    def update
      authenticate_user_from_token!
      @story.update(story_params)
      render json: @story, serializer: StorySerializer
    end

    # DELETE /v1/stories/:id
    def destroy
      authenticate_user_from_token!
      @story.destroy
      render json: {}, status: :ok
    end
    
    private

    def set_story
      @story = Story.find_by(id: params[:id])
      render json: { error: t('story_not_found_error') }, status: :not_found if @story.nil?
    end

    def story_params
      params.require(:story).permit(:title, :body).merge(user: current_user)
    end

  end
end

