class DashboardController < ApplicationController
  def index
     @posts = Post.all.order(created_at: :desc) # Trae todos los posts, más recientes primero
  end
end
