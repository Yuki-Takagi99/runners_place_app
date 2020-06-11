class PracticeCommentsController < ApplicationController
  def create
    @practice_diary = PracticeDiary.find(params[:practice_diary_id])
    @practice_comment = @practice_diary.practice_comments.build(practice_comment_params)

    respond_to do |format|
      if @practice_diary.save
        format.js { render :index }
      else
        format.html { redirect_to practice_diary_path(@practice_diary), notice: 'コメントが投稿できませんでした' }
      end
    end
  end

  private
  def practice_comment_params
    params.require(:practice_comment).permit(:practice_diary_id, :practice_comment_content)
  end

end
