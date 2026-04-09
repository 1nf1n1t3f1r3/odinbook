class UsersController < ApplicationController
  # Users must be logged in (inherited from ApplicationController)

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end
end
