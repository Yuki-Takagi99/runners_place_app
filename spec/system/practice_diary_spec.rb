require 'rails_helper'
RSpec.describe "練習記録管理機能", type: :system do

	before do
		@user = create(:user)
	end

	describe '練習記録管理' do
		context '練習記録作成、編集、削除機能' do
			it '練習記録が作成できること' do
				visit new_user_session_path
				fill_in 'Eメール', with: 'test1@example.com'
				fill_in 'パスワード', with: 'password'
				click_button 'ログイン'
				click_on '練習記録をつける'
				select_date("2019,12,31", from: "練習日")
				fill_in 'タイトル', with: '作成テスト'
				fill_in '詳細', with: '作成テスト'
				fill_in '走行距離', with: '10.0'
				select_time("01", "50", "30", from: "走行時間")
				click_on '登録する'
				expect(page).to have_content '作成テスト'
			end

			it '作成した練習記録が編集できること' do
				visit new_user_session_path
				fill_in 'Eメール', with: 'test2@example.com'
				fill_in 'パスワード', with: 'password'
				click_button 'ログイン'
				click_on '練習記録をつける'
				select_date("2019,12,31", from: "練習日")
				fill_in 'タイトル', with: '作成テスト'
				fill_in '詳細', with: '作成テスト'
				fill_in '走行距離', with: '10.0'
				select_time("01", "50", "30", from: "走行時間")
				click_on '登録する'
				click_on '編集する'
				fill_in 'タイトル', with: '編集テスト'
				click_on '更新する'
				expect(page).to have_content '編集テスト'
			end
		end
	end
end
