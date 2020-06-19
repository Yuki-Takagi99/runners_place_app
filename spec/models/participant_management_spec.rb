require 'rails_helper'

RSpec.describe ParticipantManagement, type: :model do
  describe 'バリデーションテスト' do
    before do
      @user = create(:user)
      @event = create(:event, user_id: @user.id)
      @participant_management = create(:participant_management, user_id: @user.id, event_id: @event.id)
    end

    it 'すべてのデータがある場合、有効であること' do
			expect(@participant_management).to be_valid
		end

		it 'user_idがない場合、無効であること' do
			@participant_management.user_id = nil
			expect(@participant_management).not_to be_valid
		end

		it 'event_idがない場合、無効であること' do
			@participant_management.event_id = nil
			expect(@participant_management).not_to be_valid
		end
  end
end
