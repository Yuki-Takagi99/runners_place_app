class CreateParticipantManagements < ActiveRecord::Migration[5.2]
  def change
    create_table :participant_managements do |t|
      t.references :user, foreign_key: true
      t.references :event, foreign_key: true

      t.timestamps
      t.index [:user_id, :event_id], unique: true
    end
  end
end
