class ApplicationController < ActionController::Base
  before_action :set_query

  include Authentication
  include Authorization

  def set_query
    @query = Post.ransack(params[:q])
  end
end
