require 'rails_helper'

RSpec.describe EventComment, type: :model do
  describe 'バリデーションテスト' do
    before do
      @user = create(:user)
      @event = create(:event, user_id: @user.id)
      @event_comment = create(:event_comment, user_id: @user.id, event_id: @event.id)
    end

    it 'すべてのデータがある場合、有効であること' do
      expect(@event_comment).to be_valid
    end

    it 'event_comment_contentがない場合、無効であること' do
      @event_comment.event_comment_content = nil
      expect(@event_comment).not_to be_valid
    end

    it 'event_comment_contentが151文字以上の場合、無効であること' do
      @event_comment.event_comment_content = "a" * 151
      expect(@event_comment).not_to be_valid
    end

    it 'user_idがない場合、無効であること' do
      @event_comment.user_id = nil
      expect(@event_comment).not_to be_valid
    end

    it 'event_idがない場合、無効であること' do
      @event_comment.event_id = nil
      expect(@event_comment).not_to be_valid
    end
  end
end
