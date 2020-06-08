class CreatePracticeFavorites < ActiveRecord::Migration[5.2]
  def change
    create_table :practice_favorites do |t|
      t.references :user, foreign_key: true
      t.references :practice_diary, foreign_key: true

      t.timestamps
      t.index [:user_id, :practice_diary_id], unique: true
    end
  end
end
