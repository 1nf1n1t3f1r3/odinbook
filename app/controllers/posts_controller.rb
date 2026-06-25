class PostsController < ApplicationController
  def index
    # Start with all public posts (includes user for fast loading/no N+1 queries)
    base_posts = Post.includes(:user)

scope = Post.includes(:user).by_hotness_for(current_user)

      # Pass the scope cleanly into your paginator
      @pagy, @posts = pagy(:offset, scope, limit: 10)
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
