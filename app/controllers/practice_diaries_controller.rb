class PracticeDiariesController < ApplicationController
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
			render :new
		end
	end

		def show
			@practice_diary = PracticeDiary.find(params[:id])
		end

	private

	def practice_diary_params
		params.require(:practice_diary).permit(:practice_date, :practice_title, :practice_content, :practice_distance, :practice_time)
	end
end
