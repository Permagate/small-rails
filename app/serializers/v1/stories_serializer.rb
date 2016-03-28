module V1
  class StoriesSerializer < ActiveModel::Serializer
    
    attributes :title, :created_at, :abstract, :id, :like_count
    has_one :user, serializer: V1::UserSerializer

    def abstract
      object.body[0..200]
    end

    def like_count
      object.likes.count
    end

  end
end

