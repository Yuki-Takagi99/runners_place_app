require 'rails_helper'

RSpec.describe PracticeDiary, type: :model do
	describe 'バリデーションテスト' do
		before do
			@user = create(:user)
			@practice_diary = create(:practice_diary, user_id: @user.id)
		end

		it 'すべてのデータがある場合、有効であること' do
			expect(@practice_diary).to be_valid
		end

		it 'practice_dateがない場合、無効であること' do
			@practice_diary.practice_date = nil
			expect(@practice_diary).not_to be_valid
		end

		it 'practice_dateが翌日以降の場合、無効であること' do
			@practice_diary.practice_date = Date.today + 7
			expect(@practice_diary).not_to be_valid
		end

		it 'practice_titleがない場合、無効であること' do
			@practice_diary.practice_title = nil
			expect(@practice_diary).not_to be_valid
		end

		it 'practice_titleが101文字以上の場合、無効であること' do
			@practice_diary.practice_title = 'a' * 101
			expect(@practice_diary).not_to be_valid
		end

		it 'practice_contentがない場合、無効であること' do
			@practice_diary.practice_content = nil
			expect(@practice_diary).not_to be_valid
		end

		it 'practice_contentが1001文字以上の場合、無効であること' do
			@practice_diary.practice_content = 'a' * 1001
			expect(@practice_diary).not_to be_valid
		end

		it 'practice_distanceがない場合、無効であること' do
			@practice_diary.practice_distance = nil
			expect(@practice_diary).not_to be_valid
		end
	end
end