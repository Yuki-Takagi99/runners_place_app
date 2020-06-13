class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  def show
  end

  def following
    #@userがフォローしているユーザー
    @user  = User.find(params[:id])
    @users = @user.following
    render 'show_follow'
  end

  def followers
      #@userをフォローしているユーザー
      @user  = User.find(params[:id])
      @users = @user.followers
      render 'show_follower'
  end

  private
  def set_user
    @user = User.find(params[:id])
  end
end
