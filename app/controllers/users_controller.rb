class UsersController < ApplicationController
  before_action :set_user, only: [:show]
  before_action :authenticate_user!
  before_action :user_admin, only: [:index]

  def index
    @users = User.all.includes(:practice_diaries).order(created_at: :DESC)
  end

  def show
    # 参加予定のイベントを取得
    @participant_events = @user.participant_events.recent
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

  def user_admin
    @users = User.all.includes(:practice_diaries).order(created_at: :DESC)
    if current_user.admin == false
      redirect_to root_path
    else
      render action: "index"
    end
  end
end
