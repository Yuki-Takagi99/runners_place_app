class AddColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :user_name, :string, null: false, default: ""
    add_column :users, :self_introduction, :text, null: false, default: ""
    add_column :users, :target, :text, null: false, default: ""
  end
end
