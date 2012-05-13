module ChiliLikes
  class Post < ::Post
    has_many :likes

    def well_liked?
      likes.size > 5
    end
  end
end
