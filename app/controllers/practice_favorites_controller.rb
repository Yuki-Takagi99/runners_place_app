class PracticeFavoritesController < ApplicationController
	def create
		practice_favorite = current_user.practice_favorites.create(practice_diary_id: params[:practice_diary_id])
    redirect_to practice_diaries_path, success: "#{practice_favorite.practice_diary.user.user_name}さんの練習記録をお気に入り登録しました！"
	end
	
	def destroy
		practice_favorite = current_user.practice_favorites.find_by(id: params[:id]).destroy
    redirect_to practice_diaries_path, info: "#{practice_favorite.practice_diary.user.user_name}さんの練習記録をお気に入り解除しました！"
	end
end
