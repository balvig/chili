module SocialExt
  class User < ::User
    has_many :likes
  end
end
