class PagesController < ApplicationController
  def landing
  end

  def profile
    @user = User.find(params[:user_id])
  end
end
