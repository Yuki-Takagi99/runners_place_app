class AddUserRefToPracticeComments < ActiveRecord::Migration[5.2]
  def change
    add_reference :practice_comments, :user, foreign_key: true
  end
end
