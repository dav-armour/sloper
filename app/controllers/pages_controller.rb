class PagesController < ApplicationController
  def landing
  end

  def profile
    @user = User.find(params[:user_id])
    # @avatar = current_user.image_url
  end
end
