class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @link = Link.find(params[:link_id])
    @comment = Comment.create(params[:comment].permit(:content))
    @comment.user_id = current_user.id
    @comment.link_id = @link.id

    if @comment.save
      redirect_to link_path(@link)
    else
      render "new"
    end
  end

  def destroy
    @link = Link.find(params[:link_id])
    @comment = @link.comments.find(params[:id])
    @comment.destroy

    redirect_to link_path(@link)
  end
end
