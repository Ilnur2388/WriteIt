class PagesController < ApplicationController
  def index
    @recent_post = Post.order(created_at: :desc).limit(5)
  end
end
