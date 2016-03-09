class CommentsController < ApplicationController
  before_action :is_authenticated?, except: [:index]

  def index
    @post = Post.find params[:post_id]
  end

  def new
    @post = Post.find params[:post_id]
    @comment = Comment.new
  end

  def create
    Comment.create comment_params do |c|
      c.post_id = params[:post_id]
      c.user_id = @current_user.id
      c.save
    end
    redirect_to post_comments_path(params[:post_id])
  end

  def upvote
    vote(:up)
    redirect_to :back
  end

  def downvote
    vote(:down)
    redirect_to :back
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def vote(direction)
    vote_value = direction == :up ? 1 : -1

    comment = Comment.find(params[:comment_id])
    vote = comment.votes.find_or_create_by(user_id: @current_user.id)
    vote.value = (vote.value) == vote_value ? 0 : vote_value
    vote.save!
  end
end