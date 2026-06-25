class UsersController < ApplicationController
# Users must be logged in (inherited from ApplicationController)

def index
    # 1. Capture the text parameter from your search input form
    @search_query = params[:query]

    # 2. Feed it into our relationship matrix engine
    scope = User.suggested_for(current_user, @search_query)

    # 3. Paginate the weighted collection seamlessly
    @pagy, @users = pagy(scope, limit: 10)

    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end


def show
  @user = User.find(params[:id])

  scope = @user.posts.by_hotness_for(current_user)

  @pagy, @posts = pagy(scope, limit: 5)

  # Turbo
  respond_to do |format|
    format.html
    format.turbo_stream
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
