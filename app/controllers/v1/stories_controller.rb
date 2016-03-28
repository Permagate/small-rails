module V1
  class StoriesController < ApplicationController
    # GET /v1/stories
    def index
      @stories = Story.order(created_at: :desc).where(user: current_user)
      render json: @stories, each_serializer: StoriesSerializer
    end

    # GET /v1/stories/me
    def owned
      authenticate_user_from_token!
      @stories = Story.order(created_at: :desc).where(user: current_user)
      render json: @stories, each_serializer: StoriesSerializer
    end

    # POST /v1/stories
    def create
      authenticate_user_from_token!
      @story = Story.new(story_params)
      if @story.title.nil? or @story.body.nil?
        render json: { error: 'Invalid params!' }
      else
        @story.save
        render json: @story, serializer: StorySerializer
      end
    end

    # GET /v1/stories/:id
    def show
      @story = Story.find_by(id: params[:id])
      render json: @story, serializer: StorySerializer
    end

    # PUT /v1/stories/:id
    def update
      authenticate_user_from_token!
      @story = Story.find_by(id: params[:id])
      @story.update(story_params)
      render json: @story, serializer: StorySerializer
    end

    # DELETE /v1/stories/:id
    def destroy
      authenticate_user_from_token!
      @story = Story.find_by(id: params[:id])
      @story.destroy
      render json: {}, status: :ok
    end
    
    private

    def story_params
      params.require(:story).permit(:title, :body).merge(user: current_user)
    end

  end
end

