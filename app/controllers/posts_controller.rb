class PostsController < ApplicationController
  def index
    # Cleaned up double-set base_posts snippet
    scope = Post.includes(:user).by_hotness_for(current_user)

    # Pass the scope cleanly into your paginator
    @pagy, @posts = pagy(scope, limit: 10) # Note: Removed :offset unless specifically required by your Pagy config

    respond_to do |format|
      format.html # Standard page load
      format.turbo_stream # Infinite scroll / pagination click load
    end
  end

  def show
      @post = Post.includes(comments: :user).find(params[:id])
  end

def create
  @post = current_user.posts.build(post_params)

  if @post.save
    redirect_to root_path, notice: "Post created!"
  else
    @posts = Post.includes(:user).order(created_at: :desc)
    render :index, status: :unprocessable_entity
  end
end


  def destroy
    @post = current_user.posts.find(params[:id])
    @post.destroy

    redirect_to root_path, notice: "Post deleted"
  end


  private

  def post_params
    params.require(:post).permit(:content, :image)
  end
end
