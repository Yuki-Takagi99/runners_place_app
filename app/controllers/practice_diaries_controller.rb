class PracticeDiariesController < ApplicationController
	before_action :set_practice_diary, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!

	def index
		@practice_diaries = PracticeDiary.where(user_id: current_user.id)
	end

	def index_all
		# ログインしているユーザ以外の練習記録を取得
		@practice_diaries = PracticeDiary.where.not(user_id: current_user.id)
	end

	def new
		@practice_diary = PracticeDiary.new
	end

	def create
		@practice_diary = current_user.practice_diaries.build(practice_diary_params)
		if @practice_diary.save
			redirect_to @practice_diary, success: "練習記録を作成しました!"
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
			redirect_to practice_diary_path, success: "練習記録を編集しました！"
		else
			flash.now[:danger] = "練習記録の編集に失敗しました。"
			render :edit
		end
	end

	def destroy
		@practice_diary.destroy
		redirect_to practice_diaries_path, success: "練習記録を削除しました！"
	end

	private
	def practice_diary_params
		params.require(:practice_diary).permit(:practice_date, :practice_title, :practice_content, :practice_distance, :practice_time)
	end

	def set_practice_diary
		@practice_diary = PracticeDiary.find(params[:id])
	end
end
