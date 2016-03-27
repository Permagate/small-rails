module V1
  class StoriesController < ApplicationController
    skip_before_action :authenticate_user_from_token!, only: [:index, :show]
    before_action :set_story, only: [:show, :update, :destroy]

    # GET /v1/stories
    def index
      @stories = Story.latest.all
      render json: @stories, each_serializer: StoriesSerializer
    end

    # GET /v1/stories/me
    def owned
      @stories = Story.latest.owned_by(current_user)
      render json: @stories, each_serializer: StoriesSerializer
    end

    # POST /v1/stories
    def create
      @story = Story.new(story_params)

      if @story.save
        render json: @story, serializer: StorySerializer
      else
        render json: { error: @story.errors.full_messages.first }, status: :unprocessable_entity
      end
    end

    # GET /v1/stories/:id
    def show
      render json: @story, serializer: StorySerializer
    end

    # PUT /v1/stories/:id
    def update
      if @story.update(story_params)
        render json: @story, serializer: StorySerializer
      else
        render json: { error: @story.errors.full_messages.first }, status: :unprocessable_entity
      end
    end

    # DELETE /v1/stories/:id
    def destroy
      @story.destroy
      render json: {}, status: :ok
    end
    
    private

    def set_story
      @story = Story.find_by(id: params[:id])
      render json: { error: t('story_not_found_error') }, status: :unprocessable_entity if @story.nil?
    end

    def story_params
      params.require(:story).permit(:title, :body).merge(user: current_user)
    end

  end
end

