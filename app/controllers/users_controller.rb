class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  def show
    # 参加予定のイベントを取得
    @participant_events = @user.participant_events
  end

  def following
    # @userがフォローしているユーザー
    @user  = User.find(params[:id])
    @users = @user.following
    render 'show_follow'
  end

  def followers
      # @userをフォローしているユーザー
      @user  = User.find(params[:id])
      @users = @user.followers
      render 'show_follower'
  end

  private
  def set_user
    @user = User.find(params[:id])
  end
end
