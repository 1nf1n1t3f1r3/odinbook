class UsersController < ApplicationController
  # Users must be logged in (inherited from ApplicationController)

  def index
    @pagy, @users = pagy(:offset, User.order(created_at: :desc), limit: 25)
  end

  def show
    @user = User.find(params[:id])

    scope =
      case params[:sort]
      when "top"
        @user.posts.with_hot_score.hot_ordered
      when "oldest"
        @user.posts.order(created_at: :asc)
      else
        @user.posts.order(created_at: :desc)
      end

    @pagy, @posts = pagy(:offset, scope, limit: 5)
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user

    if @user.update(user_params)
      redirect_to profile_path, notice: "Profile updated!"
    else
      render :edit
    end
  end

  def show_current
    redirect_to user_path(current_user)
  end

  private

  def user_params
    params.require(:user).permit(:username, :avatar)
  end
end
