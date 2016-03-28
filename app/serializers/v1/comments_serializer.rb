module V1
  class CommentsSerializer < ActiveModel::Serializer
    
    attributes :content, :created_at, :id, :like_count
    has_one :user, serializer: V1::UserSerializer

    def like_count
      object.likes.count
    end

  end
end
