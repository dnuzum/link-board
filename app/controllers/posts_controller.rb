class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @current_user.posts.create(post_params)
    flash[:success] = 'Post Created!'
    redirect_to post_path
  end

  def show
    @posts = Post.all
  end

  def destroy
  end

  def update
  end

  private

  def post_params
    params.require(:post).permit(:title, :link)
  end
end
