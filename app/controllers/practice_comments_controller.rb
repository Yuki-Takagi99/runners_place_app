class PracticeCommentsController < ApplicationController
  before_action :set_practice_diary, only: [:create, :edit, :update]
  def create
    @practice_diary = PracticeDiary.find(params[:practice_diary_id])
    @practice_comment = @practice_diary.practice_comments.build(practice_comment_params)
    @practice_comment.user_id = current_user.id

    respond_to do |format|
      if @practice_diary.save
        format.js { render :index }
      else
        format.html { redirect_to practice_diary_path(@practice_diary), danger: 'コメントが投稿できませんでした' }
      end
    end
  end

  def edit
    @practice_comment = @practice_diary.practice_comments.find(params[:id])
    respond_to do |format|
      flash.now[:notice] = 'コメントの編集中'
      format.js { render :edit }
    end
  end

  def update
    @practice_comment = @practice_diary.practice_comments.find(params[:id])
    respond_to do |format|
      if @practice_comment.update(practice_comment_params)
        flash.now[:notice] = 'コメントが編集されました'
        format.js { render :index }
      else
        flash.now[:danger] = 'コメントの編集に失敗しました'
        format.js { render :edit_error }
      end
    end
  end

  def destroy
    @practice_comment = PracticeComment.find(params[:id])
    @practice_comment.destroy
    respond_to do |format|
      format.js { render :index }
      flash.now[:info] = "コメントが削除されました"
    end
  end

  private
  def practice_comment_params
    params.require(:practice_comment).permit(:practice_diary_id, :practice_comment_content)
  end

  def set_practice_diary
    @practice_diary = PracticeDiary.find(params[:practice_diary_id])
  end
  

end
