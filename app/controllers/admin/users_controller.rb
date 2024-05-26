class Admin::UsersController < ApplicationController
   before_action :require_current_user
   before_action :authorize_user!

  def index
    respond_to do |format|
      format.html do
        @users = User.order(created_at: :desc)
      end

      format.zip { respond_with_zipped_users }
    end
  end


  private


  def respond_with_zipped_users
    compressed_file = Zip::OutputStream.write_buffer do |zos|
      User.order(created_at: :desc).each do |user|
        zos.put_next_entry "user_#{user.id}.xlsx"
        zos.print render_to_string(
          layout: false, hendlers: [:axlsx], formats: [:xlsx],
          template: 'admin/users/user',
          locals: {user: user}
          )
      end
    end

    compressed_file.rewind
    send_data compressed_file.read, filename: 'users.zip'
  end

  def authorize_user!
    authorize([:admin, (@user || User)])
  end
end
