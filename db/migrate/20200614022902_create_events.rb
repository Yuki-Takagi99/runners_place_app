class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.datetime :event_date
      t.string :event_title, null: false, default: ""
      t.text :event_content, null: false, default: ""
      t.integer :minimum_number_of_participant, null: false
      t.string :address
      t.float :latitude
      t.float :longitude
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
