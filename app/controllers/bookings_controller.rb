class BookingsController < ApplicationController
  def index
    @booking = params[:room]
    if @booking
      respond_to do |format|
        format.js
      end
    end
  end
end
