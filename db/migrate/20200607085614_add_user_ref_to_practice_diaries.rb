class AddUserRefToPracticeDiaries < ActiveRecord::Migration[5.2]
  def change
    add_reference :practice_diaries, :user, foreign_key: true
  end
end
