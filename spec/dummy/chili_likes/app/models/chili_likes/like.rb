module ChiliLikes
  class Like < ActiveRecord::Base
    attr_accessible :post_id
  end
end
