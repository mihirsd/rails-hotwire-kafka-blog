class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)

    if @comment.save
      redirect_to posts_path, notice: "Comment added successfully!"
    else
      redirect_to posts_path, alert: "Failed to create comment"
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :name)
  end
end
