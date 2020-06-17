class PracticeDiariesController < ApplicationController
	before_action :set_practice_diary, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!

	def index
		# 練習記録一覧ページ
		@search_params = practice_diary_search_params
		@practice_diaries = PracticeDiary.login_user_diary(current_user.id).includes(user: :practice_favorites, user: :practice_comments).recent.search(@search_params).page(params[:page]).per(10)

		# 月間走行距離の取得
		@practice_diaries_all = PracticeDiary.login_user_diary(current_user.id).includes(:user)

		# フォロー中のユーザの投稿の取得
		@user = current_user
		@users = @user.following.order("created_at DESC").limit(4)
	end

	def index_all
		# みんなの練習記録ページ
		@search_params = practice_diary_search_params
		@practice_diaries = PracticeDiary.other_user_diary(current_user.id).includes(user: :practice_favorites, user: :practice_comments).recent.search(@search_params).page(params[:page]).per(10)
	end

	def new
		@practice_diary = PracticeDiary.new
	end

	def create
		@practice_diary = current_user.practice_diaries.build(practice_diary_params)
		if @practice_diary.save
			redirect_to @practice_diary
			flash[:success] = "練習記録を作成しました!"
		else
			flash.now[:danger] = "練習記録の投稿に失敗しました。"
			render :new
		end
	end

	def show
		@practice_comments = @practice_diary.practice_comments
		@practice_comment = @practice_diary.practice_comments.build
	end

	def edit
	end

	def update
		if @practice_diary.update(practice_diary_params)
			redirect_to practice_diary_path
			flash[:success] = "練習記録を編集しました！"
		else
			flash.now[:danger] = "練習記録の編集に失敗しました。"
			render :edit
		end
	end

	def destroy
		@practice_diary.destroy
		redirect_to practice_diaries_path
		flash[:success] = "練習記録を削除しました！"
	end

	private
	def practice_diary_params
		params.require(:practice_diary).permit(:practice_date, :practice_title, :practice_content, :practice_distance, :practice_time, :user_name)
	end

	def set_practice_diary
		@practice_diary = PracticeDiary.find(params[:id])
	end

	def practice_diary_search_params
		params.fetch(:search, {}).permit(:practice_title, :practice_content, :practice_date_from, :practice_date_to, :user_name)
	end
end
