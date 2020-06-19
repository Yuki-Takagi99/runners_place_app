require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = create(:user)
  end

  describe 'バリデーションテスト' do
    it 'user_name、email、passwordがある場合、有効であること' do
      expect(@user).to be_valid
    end

    it 'user_nameがない場合、無効であること' do
      @user.user_name = nil
      expect(@user).not_to be_valid
    end

    it 'emailがない場合、無効であること' do
      @user.email = nil
      expect(@user).not_to be_valid
    end

    it 'passwordがない場合、無効であること' do
      @user.password = nil
      expect(@user).not_to be_valid
    end

    it '31文字以上のuser_nameの場合、無効であること' do
      @user.user_name = 'a' * 31
      expect(@user).not_to be_valid
    end

    it '256文字以上のemailの場合、無効であること' do
      @user.email = "#{'a' * 250}@a.com"
      expect(@user).not_to be_valid
    end

    it '重複したemailの場合、無効であること' do
      @user2 = create(:user_2)
      @user3 = create(:user_3)
      @user3.email = "unique@example.com"
      expect(@user3).not_to be_valid
    end

    it '6文字未満のpasswordを入力した場合、無効であること' do
      @user.password = 1 * 5
      expect(@user).not_to be_valid
    end
  end
end