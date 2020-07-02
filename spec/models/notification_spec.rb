require 'rails_helper'

RSpec.describe Notification, type: :model do
  describe "バリデーションテスト" do
    before do
      @user = create(:user)
      @user2 = create(:jon)
      @practice_diary = create(:practice_diary, user_id: @user.id)
      @practice_comment = create(:practice_comment, user_id: @user.id, practice_diary_id: @practice_diary.id)
      @notification = create(:notification, visitor_id: @user.id, visited_id: @user2.id, practice_diary_id: @practice_diary.id, practice_comment_id: @practice_comment.id, action: "comment", checked: "false")
    end

    it 'すべてのデータがある場合、有効であること' do
      expect(@notification).to be_valid
    end

    it 'visitor_idがない場合、無効であること' do
      @notification.visitor_id = nil
      expect(@notification).not_to be_valid
    end

    it 'visited_idがない場合、無効であること' do
      @notification.visited_id = nil
      expect(@notification).not_to be_valid
    end
  end
end
