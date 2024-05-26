module Authentication
  extend ActiveSupport::Concern

  included do
    private

    def current_user
      @current_user ||=User.find_by(id: session[:user_id]) if session[:user_id].present?
    end

    def user_sign_in?
      current_user.present?
    end

    def require_current_user
      return if user_sign_in?

      flash[:warning] = 'Вы не вошли в систему'
      redirect_to root_path
    end

    def require_no_current_user
      return if !user_sign_in?

      flash[:warning] = 'Вы уже вошли в систему'
      redirect_to root_path
    end

    def sign_in(user)
      session[:user_id] = user.id
    end

    def sign_out
      session.delete :user_id
    end

    helper_method :current_user, :user_sign_in?
  end
end
