class FollowsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def create
    current_user.following_relationships.create!(followed: @user)

    respond_to do |format|
      # If it's a Turbo Frame request, just re-render the button fragment!
      format.html {
        if turbo_frame_request?
          render partial: "follows/follow_button", locals: { user: @user }
        else
          redirect_back fallback_location: root_path
        end
      }
    end
  end

  def destroy
    current_user.following_relationships.find_by(followed: @user)&.destroy

    respond_to do |format|
      format.html {
        if turbo_frame_request?
          render partial: "follows/follow_button", locals: { user: @user }
        else
          redirect_back fallback_location: root_path
        end
      }
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end
end
