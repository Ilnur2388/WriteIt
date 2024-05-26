class SessionsController < ApplicationController
  before_action :require_no_current_user, only: %i[new create]
  before_action :require_current_user, only: :destroy

  def new
    @user = User.new
  end

  def create
    user = User.find_by name: params[:name]
    if user&.authenticate(params[:password])
      sign_in user
      flash[:success] = "Вы вошли!"
      redirect_to root_path
    else
      flash.now[:warning] = 'Некорректный логин или пароль'
      redirect_to new_session_path
    end
  end

  def destroy
    sign_out
    flash[:success] = 'Вы вышли из аккаунта'
    redirect_to root_path
  end
end
