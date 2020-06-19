require 'rails_helper'

RSpec.describe PracticeFavorite, type: :model do
	describe 'バリデーションテスト' do
		before do
			@user = create(:user)
			@practice_diary = create(:practice_diary, user_id: @user.id)
			@practice_favorite = create(:practice_favorite, user_id: @user.id, practice_diary_id: @practice_diary.id)
			@practice_favorite2 = build(:practice_favorite, user_id: @user.id, practice_diary_id: @practice_diary.id)
		end

		it 'すべてのデータがある場合、有効であること' do
			expect(@practice_favorite).to be_valid
		end

		it '重複してお気に入り登録した場合、無効であること' do
			expect(@practice_favorite2).not_to be_valid
		end

		it 'user_idがない場合、無効であること' do
			@practice_favorite.user_id = nil
			expect(@practice_favorite).not_to be_valid
		end

		it 'practice_diary_idがない場合、無効であること' do
			@practice_favorite.practice_diary_id = nil
			expect(@practice_favorite).not_to be_valid
		end
	end
end