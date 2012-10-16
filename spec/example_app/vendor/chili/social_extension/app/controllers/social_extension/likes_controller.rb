module SocialExtension
  class LikesController < ApplicationController

    def index
      @likes = current_user.likes
    end

    def create
      @like = current_user.likes.create!(params[:like])
      redirect_to :back, notice: 'Post liked!'
    end

    private

    def current_user
      super.becomes(SocialExtension::User)
    end

  end
end
