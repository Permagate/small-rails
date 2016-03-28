module V1
  class CommentsController < ApplicationController
    before_action :set_comment, only: [:update, :destroy]

    # GET /v1/comments/me
    def owned
      authenticate_user_from_token!
      @comments = Comment.order(created_at: :desc).where(user: current_user)
      render json: @comments, each_serializer: CommentsSerializer
    end

    # POST /v1/comments
    def create
      authenticate_user_from_token!
      @comment = Comment.new(comment_params)
      if @comment.content.nil? or @comment.story_id.nil?
        render json: { error: 'Invalid params!' }
      else
        @comment.save
        render json: @comment, serializer: CommentSerializer
      end
    end

    # PUT /v1/comments/:id
    def update
      authenticate_user_from_token!
      @comment.update(comment_params)
      render json: @comment, serializer: CommentSerializer
    end

    # DELETE /v1/comments/:id
    def destroy
      authenticate_user_from_token!
      @comment.destroy
      render json: {}, status: :ok
    end

    private

    def set_comment
      @comment = Comment.find_by(id: params[:id])
      render json: { error: t('comment_not_found_error') }, status: :not_found if @comment.nil?
    end

    def comment_params
      params.require(:comment).permit(:content, :story_id).merge(user: current_user)
    end
  end
end
