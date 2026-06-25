class UsersController < ApplicationController
  # Users must be logged in (inherited from ApplicationController)

  def index
    @pagy, @users = pagy(User.order(created_at: :desc), limit: 25)

    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end


def show
    @user = User.find(params[:id])

    # Note: Using your clean global sorting fallback since we dropped the tabs!
    scope = @user.posts.by_hotness_for(current_user)

    @pagy, @posts = pagy(scope, limit: 5)

    respond_to do |format|
      format.html
      format.turbo_stream # Adds support for our scroll loader
    end
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
