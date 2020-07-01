class FriendshipsController < ApplicationController
  def create
    @user = User.find(params[:following_id])
    current_user.follow(@user)
    # 通知機能用
    @user.create_notification_follow!(current_user)
    respond_to do |format|
      format.html {redirect_back(fallback_location: root_url)}
      format.js
    end
  end

  def destroy
    @user = User.find(params[:id])
    current_user.unfollow(@user)
  end
end
