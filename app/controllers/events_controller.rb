class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    @events = Event.includes(:event_comments).recent.page(params[:page]).per(30)
    @events_all = Event.includes(:event_comments).recent
  end

  def show
    @event_comments = @event.event_comments.includes(:user, :event)
    @event_comment = @event.event_comments.build
    # イベント参加者の一覧を取得
    @participant_users = @event.participant_users
  end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.events.build(event_params)
    if @event.save
      redirect_to @event, notice: "イベントを作成しました！"
    else
      flash.now[:alert] = "イベントの投稿に失敗しました。エラーを確認してください。"
      render :new
    end
  end

  def edit
  end

  def update
    if @event.update(event_params)
      redirect_to @event, notice: 'イベントを編集しました！'
    else
      flash.now[:alert] = "イベントの編集に失敗しました。エラーを確認してください。"
      render :edit
    end
  end

  def destroy
    @event.destroy
    redirect_to events_path, notice: 'イベントを削除しました！'
  end

  private
  def event_params
    params.require(:event).permit(:event_date, :event_title, :event_content, :minimum_number_of_participant, :address, :latitude, :longitude)
  end

  def set_event
		@event = Event.find(params[:id])
	end
end
