module V1
  class CommentsSerializer < ActiveModel::Serializer
    
    attributes :content, :created_at, :id
    has_one :user, serializer: V1::UserSerializer

  end
end
