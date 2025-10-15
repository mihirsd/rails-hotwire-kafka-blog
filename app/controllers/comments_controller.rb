class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)

    respond_to do |format|
      if @comment.save
        format.turbo_stream
        format.html { redirect_to posts_path }
      else
        format.html { redirect_to posts_path, alert: "Failed to create comment" }
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :name)
  end
end
