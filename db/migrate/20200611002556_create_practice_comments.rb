class CreatePracticeComments < ActiveRecord::Migration[5.2]
  def change
    create_table :practice_comments do |t|
      t.text :practice_comment_content
      t.references :practice_diary, foreign_key: true

      t.timestamps
    end
  end
end
