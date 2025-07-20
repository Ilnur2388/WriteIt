class UsersController < ApplicationController
  before_action :require_no_current_user, only: %i[new create]
  before_action :require_current_user, only: %i[edit update]
  before_action :set_user!, only: %i[edit update]
  before_action :authorize_user!

  def new
    @user = User.new
  end

  def edit
  end

  def update
    if @user.update user_params
      flash[:success] = 'Ваш профиль обновлен'
      redirect_to edit_user_path(@user)
    else
      render :edit
    end
  end

  def create
    @user = User.new user_params
    if @user.save
      sign_in @user
      flash[:success] = "Привет, #{@user.name}!"
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def set_user!
    @user = User.find params[:id]
  end

  def user_params
    params.require(:user).permit(:city, :name, :family_name, :password, :password_confirmation, :avatar)
  end

  def authorize_user!
    authorize(@user || User)
  end
end
