class CommentsController < ApplicationController
  
  def new
    @comment = Comment.new
    @comment.user_id = current_user.id
    @comment.post_id = params[:post_id]
    respond_to do |format|
      format.html
      format.js
    end
  end
  
  def create
    @comment = current_user.comments.new(comment_params)
    if @comment.save
      redirect_to posts_path, success: "コメントしました"
    else
      redirect_to posts_path, denger: "コメント登録に失敗しました"
    end 
  end 

  def destroy
    post = Post.find(params[:post_id])
    @comment = post.comments.find(params[:id])
    @comment.destroy
    redirect_back(fallback_location: post_path(post))
  end
  
  private
  def comment_params
    params.require(:comment).permit(:user_id, :post_id, :content)
  end 
end
