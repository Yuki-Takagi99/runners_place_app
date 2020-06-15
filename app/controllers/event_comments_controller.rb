class EventCommentsController < ApplicationController
  before_action :set_event, only: [:create, :edit, :update, :destroy]

  def create
    @event_comment = @event.event_comments.build(event_comment_params)
    @event_comment.user_id = current_user.id

    respond_to do |format|
      if @event_comment.save
        flash.now[:success] = 'コメントが投稿されました！'
        format.js { render :index }
      else
        flash.now[:danger] = 'コメントの投稿に失敗しました。。。'
        format.js { render :error }
      end
    end
  end

  def edit
    @event_comment = @event.event_comments.find(params[:id])
    respond_to do |format|
      flash.now[:warning] = '編集中...'
      format.js { render :edit }
    end
  end

  def update
    @event_comment = @event.event_comments.find(params[:id])
    respond_to do |format|
      if @event_comment.update(event_comment_params)
        flash.now[:success] = 'コメントが編集されました！'
        format.js { render :index }
      else
        flash.now[:danger] = 'コメントの編集に失敗しました。。。'
        format.js { render :edit_error }
      end
    end
  end

  def destroy
    @event_comment = EventComment.find(params[:id])
    @event_comment.destroy
    respond_to do |format|
      flash.now[:success] = 'コメントが削除されました！'
      format.js { render :index }
    end
  end

  private
  def event_comment_params
    params.require(:event_comment).permit(:event_id, :event_comment_content, :user_id)
  end

  def set_event
    @event = Event.find(params[:event_id])
  end
end
