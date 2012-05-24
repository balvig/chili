module ChiliSocial
  class LikesController < Chili::ApplicationController

    def index
      @likes = current_user.becomes(ChiliSocial::User).likes
    end

    def create
      @like = current_user.becomes(ChiliSocial::User).likes.create!(params[:like])
      redirect_to :back, notice: 'Post liked!'
    end

  end
end
