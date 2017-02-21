class UsersController < ApplicationController
  def links
    @user = User.find(params[:id])
    @links = @user.links
  end
end
