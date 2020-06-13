require 'rails_helper'

RSpec.describe Friendship, type: :model do
  describe "バリデーションテスト" do
    before do
      @user = create(:user)
      @user2 = create(:user_2)
      @friendship = create(:friendship, follower_id: @user.id, following_id: @user2.id)
    end
    it 'データがあれば有効となること' do
      expect(@friendship).to be_valid
    end
    it 'follower_idが欠けている場合は無効となること' do
      @friendship.follower_id = nil
      expect(@friendship).not_to be_valid
    end
  end
end
