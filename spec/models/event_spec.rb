require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'バリデーションテスト' do
    it 'データがあれば有効であること' do
      create(:user)
      event = create(:event)
      expect(event).to be_valid
    end
    it 'event_dateが本日より前の日付であれば無効であること' do
      create(:user)
      event = create(:event)
      event.event_date = Date.today - 1
      expect(event).not_to be_valid
    end
    it 'event_titleがなければ無効であること' do
      create(:user)
      event = create(:event)
      event.event_title = nil
      expect(event).not_to be_valid
    end
    it 'event_titleが101文字以上であれば無効であること' do
      create(:user)
      event = create(:event)
      event.event_title = 'a' * 101
      expect(event).not_to be_valid
    end
    it 'event_contentがなければ無効であること' do
      create(:user)
      event = create(:event)
      event.event_content = nil
      expect(event).not_to be_valid
    end
    it 'event_contentが1001文字以上であれば無効であること' do
      create(:user)
      event = create(:event)
      event.event_content = 'a' * 1001
      expect(event).not_to be_valid
    end
    it 'minimum_number_of_participantがなければ無効であること' do
      create(:user)
      event = create(:event)
      event.minimum_number_of_participant = nil
      expect(event).not_to be_valid
    end
    it 'minimum_number_of_participantが1より少なければ無効であること' do
      create(:user)
      event = create(:event)
      event.minimum_number_of_participant = 0
      expect(event).not_to be_valid
    end
  end
end