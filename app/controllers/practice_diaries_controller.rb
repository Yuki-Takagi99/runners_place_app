class PracticeDiariesController < ApplicationController
	before_action :set_practice_diary, only: [:show, :edit, :update]
	def index
		@practice_diaries = PracticeDiary.all
	end

	def new
		@practice_diary = PracticeDiary.new
	end

	def create
		@practice_diary = PracticeDiary.new(practice_diary_params)
		if @practice_diary.save
			redirect_to @practice_diary, notice: "練習記録を作成しました!"
		else
			flash.now[:alert] = "練習記録の投稿に失敗しました。"
			render :new
		end
	end

	def show
	end

	def edit
	end
	
	def update
		if @practice_diary.update(practice_diary_params)
			redirect_to practice_diary_path, notice: "練習記録を編集しました！"
		else
			flash.now[:alert] = "練習記録の編集に失敗しました。"
			render :edit
		end
	end
	

	private
	def practice_diary_params
		params.require(:practice_diary).permit(:practice_date, :practice_title, :practice_content, :practice_distance, :practice_time)
	end

	def set_practice_diary
		@practice_diary = PracticeDiary.find(params[:id])
	end
end
