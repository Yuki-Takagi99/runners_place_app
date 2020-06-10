class PracticeFavoritesController < ApplicationController
	def create
		practice_favorite = current_user.practice_favorites.build(practice_diary_id: params[:practice_diary_id])
		practice_favorite.save
		redirect_to practice_diaries_path, success: "#{practice_favorite.practice_diary.user.user_name}さんの練習記録をお気に入り登録しました！"
	end
	
	def destroy
		practice_favorite = PracticeFavorite.find_by(practice_diary_id: params[:practice_diary_id], user_id: current_user.id)
		practice_favorite.destroy
		redirect_to practice_diaries_path, info: "#{practice_favorite.practice_diary.user.user_name}さんの練習記録をお気に入り解除しました！"
	end
end
