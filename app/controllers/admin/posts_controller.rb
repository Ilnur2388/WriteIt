class Admin::PostsController < ApplicationController
   before_action :set_post!, only: %i[edit update destroy]

  def index
    @posts = Post.where(state: :review).order(created_at: :desc)
  end

  def update
    @post.update post_params
    flash[:success] =
      post_params[:state] == :approved ? 'Пост отклонен!' : 'Пост утвержден!'
    redirect_to admin_posts_path
  end

  def edit
  end

  def destroy
    @post.destroy
    redirect_to admin_posts_path
    flash[:success] = 'Пост удален'
  end

  private

  def set_post!
    @post = Post.find params[:id]
  end

  def post_params
    params.require(:post).permit(:state)
  end
end
