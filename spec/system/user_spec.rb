require 'rails_helper'
RSpec.describe "ユーザー登録、ログイン、ログアウト機能", type: :system do

	describe 'ユーザー新規登録' do
		context 'ユーザー作成機能' do
			it 'ユーザーが新規に作成でき、同時にログインされること' do
				visit new_user_registration_path
				fill_in 'ユーザー名', with: 'test'
				fill_in 'メールアドレス', with: 'test@example.com'
				fill_in 'パスワード', with: 'password'
				fill_in 'パスワード（確認用）', with: 'password'
				click_button 'アカウント登録'
				expect(page).to have_content 'アカウント登録が完了しました。'
			end
		end

		context 'ログイン、ログアウト機能' do
			before do
				create(:sample_user)
				visit new_user_session_path
				fill_in 'Eメール', with: 'sample_user@example.com'
				fill_in 'パスワード', with: 'password'
				click_button 'ログイン'
			end

			it 'ログイン後、練習記録一覧画面に遷移すること' do
				expect(page).to have_content 'ログインしました。'
				expect(current_path).to eq practice_diaries_path
			end

			it '正しくログアウトができること' do
				click_on 'ログアウト'
				expect(current_path).to eq new_user_session_path
			end
		end
	end
end