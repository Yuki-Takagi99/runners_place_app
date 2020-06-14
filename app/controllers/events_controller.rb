class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def index
    @events = Event.all
  end

  def show
  end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.events.build(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, success: "イベントを作成しました!" }
        format.js { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.js { render :new }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'イベントを編集しました' }
        format.js { render :show, status: :ok, location: @event }
      else
        format.html { render :edit, notice: 'イベントが編集できませんでした' }
      end
    end
  end

  def destroy
  end

  private
  def event_params
    params.require(:event).permit(:event_date, :event_title, :event_content, :minimum_number_of_participant, :address, :latitude, :longitude)
  end

  def set_event
		@event = Event.find(params[:id])
	end
end
