require 'rails_helper'
RSpec.describe "お気に入り機能", type: :system do

	before do
		@user = create(:user)
		@sample_user = create(:sample_user)

		@practice_diary = create(:practice_diary, user: @sample_user)
	end

	describe '練習記録のお気に入り機能' do
		context 'まだお気に入りしていないとき' do
			it '他人の練習記録をお気に入りできること' do
				visit new_user_session_path
				fill_in 'Eメール', with: 'test1@example.com'
				fill_in 'パスワード', with: 'password'
				click_button 'ログイン'
				click_on 'test_title'
				click_on 'お気に入りする'
				expect(page).to have_content 'sample_userさんの練習記録をお気に入り登録しました！'
			end

			it '他人の練習記録をお気に入り解除できること' do
				visit new_user_session_path
				fill_in 'Eメール', with: 'test2@example.com'
				fill_in 'パスワード', with: 'password'
				click_button 'ログイン'
				click_on 'test_title'
				click_on 'お気に入りする'
				click_on 'test_title'
				click_on 'お気に入り解除する'
				expect(page).to have_content 'sample_userさんの練習記録をお気に入り解除しました！'
			end
		end
	end
end
