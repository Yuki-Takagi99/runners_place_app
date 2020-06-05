class CreatePracticeDiaries < ActiveRecord::Migration[5.2]
  def change
    create_table :practice_diaries do |t|
      t.date :practice_date
      t.string :practice_title, null: false
      t.text :practice_content, null: false
      t.float :practice_distance, null: false
      t.time :practice_time
      t.timestamps
    end
  end
end
