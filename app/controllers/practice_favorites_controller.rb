class PracticeFavoritesController < ApplicationController
  def create
    @practice_diary = PracticeDiary.find(params[:practice_diary_id])
    practice_favorite = current_user.practice_favorites.build(practice_diary_id: params[:practice_diary_id])
    practice_favorite.save
    # 通知機能用
    @practice_diary.create_notification_favorite!(current_user)
    respond_to do |format|
      format.html { redirect_back(fallback_location: root_url) }
      format.js
    end
  end

  def destroy
    @practice_diary = PracticeDiary.find(params[:practice_diary_id])
    practice_favorite = PracticeFavorite.find_by(practice_diary_id: params[:practice_diary_id], user_id: current_user.id)
    practice_favorite.destroy
  end
end
