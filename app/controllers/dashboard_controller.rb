class DashboardController < ApplicationController
  before_filter :authenticate_user!
  
  def show
    @posts = current_user.posts.order("published_at DESC")
  end
  
end
