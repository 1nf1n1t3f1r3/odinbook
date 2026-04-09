class UsersController < ApplicationController
  # Users must be logged in (inherited from ApplicationController)

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order(created_at: :desc) # we’ll use this later
  end
end
