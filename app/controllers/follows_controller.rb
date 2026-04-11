class FollowsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def create
    current_user.following_relationships.create!(followed: @user)
    redirect_back fallback_location: root_path
  end

  def destroy
    current_user.following_relationships.find_by(followed: @user)&.destroy
    redirect_back fallback_location: root_path
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end
end
