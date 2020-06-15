class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def index
    @events = Event.all.recent
  end

  def show
  end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.events.build(event_params)
    if @event.save
      redirect_to @event, success: 'イベントを作成しました!'
    else
      render :new, notice: 'イベントが作成できませんでした'
    end
  end

  def edit
  end

  def update
    if @event.update(event_params)
      redirect_to @event, notice: 'イベントを編集しました'
    else
      render :edit, notice: 'イベントが編集できませんでした'
    end
  end

  def destroy
    @event.destroy
    redirect_to events_path, success: 'イベントを削除しました'
  end

  private
  def event_params
    params.require(:event).permit(:event_date, :event_title, :event_content, :minimum_number_of_participant, :address, :latitude, :longitude)
  end

  def set_event
		@event = Event.find(params[:id])
	end
end
