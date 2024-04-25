class CommentsController < ApplicationController

  def create
    @prototype = Prototype.find(params[:prototype_id])
    @comment = Comment.create(comment_params)
    if @comment.save
      redirect_to prototype_path(@prototype)
    else
      @comments = Comment.all
      render "prototypes/show", status: :unprocessable_entity
    end
  end

  def show
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end
  
  private
  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id,prototype_id: params[:prototype_id])
  end
end
