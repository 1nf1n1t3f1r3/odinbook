class UsersController < ApplicationController
# Users must be logged in (inherited from ApplicationController)


def index
  @search_query = params[:query]
  target_user_id = params[:user_id]
  filter_by = params[:filter_by]

  # 1. Establish our baseline scope depending on profile interactions
  if filter_by.present? && target_user_id.present?
    target_user = User.find(target_user_id)

    base_scope = if filter_by == "followers"
                   target_user.followers
    else
                   target_user.following
    end

    # 2. Run the affinity sorting logic against only that subset of users
    scope = base_scope.where.not(id: current_user.id)

    # Optional: Calculate connection score if needed, or simply sort alphabetically/by connection
    scope = scope.select("users.*").order("username ASC")
  else
    # Default behavior: Fall back to full database discovery ranking + fuzzy text search
    scope = User.suggested_for(current_user, @search_query)
  end

  # 3. Paginate the resulting scoped collection cleanly
  @pagy, @users = pagy(scope, limit: 25)

  respond_to do |format|
    format.html {
    if turbo_frame_request?
      response.set_header("Turbo-Frame", "users_search_results_frame")
    end
  }
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
