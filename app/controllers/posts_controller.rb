class PostsController < ApplicationController
  include ActionView::RecordIdentifier

  def index
    @posts = Post.includes(:comments).order(created_at: :desc)
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.turbo_stream
        format.html { redirect_to posts_path, notice: "Post created successfully!" }
      else
        format.turbo_stream {
          render turbo_stream: turbo_stream.replace(
            "post_form",
            partial: "posts/form",
            locals: { post: @post }
          )
        }
        format.html { render :index, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove(dom_id(@post)) }
      format.html { redirect_to posts_path, notice: "Post deleted successfully!" }
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
