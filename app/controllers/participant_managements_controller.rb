class ParticipantManagementsController < ApplicationController
  def create
    @event = Event.find(params[:event_id])
    participant_management = current_user.participant_managements.build(event_id: params[:event_id])
    participant_management.save
  end
  def destroy
    @event = Event.find(params[:event_id])
    participant_management = ParticipantManagement.find_by(event_id: params[:event_id], user_id: current_user.id)
    participant_management.destroy
  end
end
