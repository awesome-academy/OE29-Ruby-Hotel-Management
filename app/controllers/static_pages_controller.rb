class StaticPagesController < ApplicationController
  before_action :new_user
  def home; end

  def about; end

  def contact; end

  private
  def new_user
    @user = User.new
  end
end
