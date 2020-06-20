require 'rails_helper'

RSpec.describe Friendship, type: :model do
  describe "バリデーションテスト" do
    before do
      @user = create(:user)
      @user2 = create(:jon)
      @friendship = create(:friendship, follower_id: @user.id, following_id: @user2.id)
    end

    it 'すべてのデータがある場合、有効であること' do
      expect(@friendship).to be_valid
    end

    it 'follower_idがない場合、無効となること' do
      @friendship.follower_id = nil
      expect(@friendship).not_to be_valid
    end

    it 'following_idがない場合、無効となること' do
      @friendship.following_id = nil
      expect(@friendship).not_to be_valid
    end
  end
end
