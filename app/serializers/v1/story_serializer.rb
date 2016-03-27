module V1
  class StorySerializer < ActiveModel::Serializer

    attributes :title, :body, :created_at, :abstract, :id
    has_one :user, serializer: V1::UserSerializer
    has_many :comments, serializer: V1::CommentsSerializer
    
    def abstract
      object.body[0..200]
    end

  end
end

