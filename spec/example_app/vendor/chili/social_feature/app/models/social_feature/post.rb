module SocialFeature
  class Post < ::Post
    has_many :likes

    def well_liked?
      likes.size >= 3
    end
  end
end
