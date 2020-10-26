class CommentsController < ApplicationController
  before_action :find_commentable, only: :create
  before_action :find_room, only: %i(destroy create)

  def create
    @comment = @commentable.comments.build comment_params
    @comment.user = current_user
    @comment.save
    respond_to :js
  end

  def destroy
    @comment = Comment.find params[:id]
    @comment.destroy
    respond_to :js
  end

  private

  def comment_params
    params.require(:comment).permit Comment::COMMENT_PARAM
  end

  def find_commentable
    sub_comment_id = params[:comment][:comment_id]
    @commentable = Comment.find params[:comment_id] if params[:comment_id]
    @commentable = Comment.find sub_comment_id if sub_comment_id
    @commentable = Room.find params[:room_id] if params[:room_id]
  end

  def find_room
    @room = Room.find params[:room_id] if params[:room_id]
  end
end
