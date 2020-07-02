class AddColumnToNotifications < ActiveRecord::Migration[5.2]
  def change
    add_reference :notifications, :event, foreign_key: true
    add_reference :notifications, :event_comment, foreign_key: true
  end
end
