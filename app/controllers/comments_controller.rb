class CommentsController < ApplicationController
  include ActionView::RecordIdentifier

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)

    respond_to do |format|
      if @comment.save
        format.turbo_stream
        format.html { redirect_to posts_path }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace("#{dom_id(@post)}_comment_form", partial: "comments/form", locals: { post: @post, comment: @comment }) }
        format.html { redirect_to posts_path, alert: "Failed to create comment" }
      end
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove(dom_id(@comment)) }
      format.html { redirect_to posts_path, notice: "Comment deleted successfully!" }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :name)
  end
end
