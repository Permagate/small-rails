module V1
  class CommentsController < ApplicationController
    before_action :set_comment, only: [:update, :destroy, :like]

    # GET /v1/comments/me
    def owned
      @comments = Comment.latest.owned_by(current_user)
      render json: @comments, each_serializer: CommentsSerializer
    end

    # POST /v1/comments
    def create
      @comment = Comment.new(comment_params)

      if @comment.save
        render json: @comment, serializer: CommentSerializer
      else
        render json: { error: @comment.errors.full_messages.first }, status: :unprocessable_entity
      end
    end

    # PUT /v1/comments/:id
    def update
      if @comment.update(comment_params)
        render json: @comment, serializer: CommentSerializer
      else
        render json: { error: @comment.errors.full_messages.first }, status: :unprocessable_entity
      end
    end

    # DELETE /v1/comments/:id
    def destroy
      @comment.destroy
      render json: {}, status: :ok
    end

    # POST /v1/comments/:id/like
    def like
      begin
        @comment.like(current_user)
        render json: {}, status: :ok
      rescue => e
        render json: { error: 'Already likes the comment.' }, status: :unprocessable_entity
      end
    end

    private

    def set_comment
      @comment = Comment.find_by(id: params[:id])
      render json: { error: t('comment_not_found_error') }, status: :unprocessable_entity if @comment.nil?
    end

    def comment_params
      params.require(:comment).permit(:content, :story_id).merge(user: current_user)
    end

  end
end
