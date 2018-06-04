class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  # Rather than getting rid of this, I think it would be better to have exceptions for non-authenticated actions
  #   like this: before_action :authenticate_user!, :except => [:example_action]

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def route_user_to_posts
    if user_signed_in?
      redirect_to :controller => 'posts', :action => 'index'
    else
      redirect_to :controller => 'pages', :action => 'home'
    end
  end
end
