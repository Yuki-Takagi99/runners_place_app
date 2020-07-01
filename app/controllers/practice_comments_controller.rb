class PracticeCommentsController < ApplicationController
  before_action :set_practice_diary, only: [:create, :edit, :update, :destroy]

  def create
    @practice_comment = @practice_diary.practice_comments.build(practice_comment_params)
    @practice_comment.user_id = current_user.id

    respond_to do |format|
      if @practice_comment.save
        flash.now[:notice] = 'コメントを作成しました！'
        format.js { render :index }
        # 通知機能用
        @practice_diary = @practice_comment.practice_diary
        @practice_diary.create_notification_comment!(current_user, @practice_comment.id)
      else
        flash.now[:alert] = 'コメントの投稿に失敗しました。'
        format.js { render :error }
      end
    end
  end

  def edit
    @practice_comment = @practice_diary.practice_comments.find(params[:id])
    respond_to do |format|
      flash.now[:alert] = '編集中...'
      format.js { render :edit }
    end
  end

  def update
    @practice_comment = @practice_diary.practice_comments.find(params[:id])
    respond_to do |format|
      if @practice_comment.update(practice_comment_params)
        flash.now[:notice] = 'コメントを編集しました！'
        format.js { render :index }
      else
        flash.now[:alert] = 'コメントの編集に失敗しました。'
        format.js { render :edit_error }
      end
    end
  end

  def destroy
    @practice_comment = PracticeComment.find(params[:id])
    @practice_comment.destroy
    respond_to do |format|
      flash.now[:notice] = 'コメントを削除しました！'
      format.js { render :index }
    end
  end

  private
  def practice_comment_params
    params.require(:practice_comment).permit(:practice_diary_id, :practice_comment_content, :user_id)
  end

  def set_practice_diary
    @practice_diary = PracticeDiary.find(params[:practice_diary_id])
  end
end
