class PagesController < ApplicationController
  skip_before_action :authenticate_user!

  # If user is not signed in, show home page (login, sign up, etc options)
  def home
    redirect_to :controller => 'posts', :action => 'index' unless !user_signed_in?
  end

  def form
  end

  def contact
  end

  # static about page
  def about
    render template: "pages/about"
  end
end
