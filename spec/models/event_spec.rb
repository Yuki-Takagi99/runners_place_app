require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'バリデーションテスト' do
    before do
      @user = create(:user)
      @event = create(:event, user_id: @user.id)
    end

    it 'すべてのデータがある場合、有効であること' do
      expect(@event).to be_valid
    end
    it 'event_dateが本日以前の日付の場合、無効であること' do
      @event.event_date = Date.today - 1
      expect(@event).not_to be_valid
    end
    it 'event_titleがない場合、無効であること' do
      @event.event_title = nil
      expect(@event).not_to be_valid
    end
    it 'event_titleが101文字以上の場合、無効であること' do
      @event.event_title = 'a' * 101
      expect(@event).not_to be_valid
    end
    it 'event_contentがない場合、無効であること' do
      @event.event_content = nil
      expect(@event).not_to be_valid
    end
    it 'event_contentが1001文字以上の場合、無効であること' do
      @event.event_content = 'a' * 1001
      expect(@event).not_to be_valid
    end
    it 'minimum_number_of_participantがない場合、無効であること' do
      @event.minimum_number_of_participant = nil
      expect(@event).not_to be_valid
    end
    it 'minimum_number_of_participantが1より少ない場合、無効であること' do
      @event.minimum_number_of_participant = 0
      expect(@event).not_to be_valid
    end

    it 'addressが50文字以上の場合、無効であること' do
      @event.address = 'a' * 51
      expect(@event).not_to be_valid
    end
  end
end