module V1
  class CommentSerializer < ActiveModel::Serializer
    
    attributes :content, :created_at, :id
    has_one :user, serializer: V1::UserSerializer
    has_one :story, serializer: V1::ShortStorySerializer

  end
end
