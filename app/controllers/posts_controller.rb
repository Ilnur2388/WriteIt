class PostsController < ApplicationController
  before_action :require_current_user
  before_action :set_post!, only: %i[destroy edit update]
  before_action :authorize_post!

  def index
    @posts = Post.where(city: current_user.city)
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build post_params
    @post.city = current_user.city if current_user.basic?
    @post.state = params[:draft] ? :draft : :review
    if @post.save
      flash[:success] = 'Пост создан успешно!'
      redirect_to posts_path
    else
      flash[:warning] = 'Не удается создать пост!'
      render :new
    end
  end

  def edit
  end

  def update
    if @post.update post_params
      @post.images.attach(params[:post][:images])
      flash[:success] = 'Пост успешно отредактирован!'
      redirect_to posts_path
    else
      render :edit
    end
  end

  def destroy
    if @post.state == 'draft'
      @post.destroy
      flash[:success] = 'Пост удален!'
    else
      flash[:warning] = 'Пост не может быть удален'
    end
    redirect_to posts_path
  end

  private

  def set_post!
    @post = Post.find params[:id]
  end

  # def send_post!
  #   @post.city == current_user.city
  # end

  def post_params
    params.require(:post).permit(:title, :body, :state, :city, images: [])
  end

  def authorize_post!
    authorize(@post || Post)
  end
end
