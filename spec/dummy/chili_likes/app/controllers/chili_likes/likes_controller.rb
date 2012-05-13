module ChiliLikes
  class LikesController < Chili::ApplicationController

    def index
      @likes = current_user.becomes(ChiliLikes::User).likes
    end

    def create
      @like = current_user.becomes(ChiliLikes::User).likes.create!(params[:like])
      redirect_to :back, notice: 'Post liked!'
    end

  end
end
