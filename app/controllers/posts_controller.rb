class PostsController < ApplicationController
def index
  @posts =
    case params[:sort]
    when "top"
      Post.feed_for(current_user).with_hot_score.hot_ordered
    else
      Post.feed_for(current_user).order(created_at: :desc)
    end
    .limit(25)
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
