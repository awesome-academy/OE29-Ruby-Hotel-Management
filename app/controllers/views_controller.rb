class ViewsController < ApplicationController
  def index
    @q = Room.ransack params[:q]
    @rooms = @q.result.page(params[:page]).per Settings.rooms.rooms_to_show
    respond_to do |format|
      format.js
      format.html
    end
  end
end
