module SocialFeature
  class Like < ActiveRecord::Base
    belongs_to :post
  end
end
