require 'rails_helper'

RSpec.describe 'User', type: :system do
	let!(:user) { create(:user) }
	let!(:other_user) { create(:user) }

	describe 'アカウント作成' do
		context 'データが正しく入力されている場合' do
			it 'ユーザー作成と同時にログインし、練習記録一覧画面に遷移すること' do
				visit new_user_registration_path
				fill_in 'ユーザー名', with: 'test'
				fill_in 'Eメール', with: 'test@example.com'
				fill_in 'パスワード', with: 'password'
				fill_in 'パスワード（確認用）', with: 'password'
				click_button 'アカウント登録'
				expect(current_path).to eq practice_diaries_path
			end
		end

		context 'emailが未入力の場合' do
			it 'ユーザーの新規作成が失敗すること' do
				visit new_user_registration_path
				fill_in 'ユーザー名', with: 'test'
				fill_in 'Eメール', with: nil
				fill_in 'パスワード', with: 'password'
				fill_in 'パスワード（確認用）', with: 'password'
				click_button 'アカウント登録'
				expect(current_path).to eq user_registration_path
				expect(page).to have_content 'Eメールを入力してください'
				expect(page).to have_content 'Eメールは不正な値です'
			end
		end

		context 'emailが登録済みのアドレスと同じ場合' do
			it 'ユーザーの新規作成が失敗すること' do
				visit new_user_registration_path
				fill_in 'ユーザー名', with: 'test'
				fill_in 'Eメール', with: user.email
				fill_in 'パスワード', with: 'password'
				fill_in 'パスワード（確認用）', with: 'password'
				click_button 'アカウント登録'
				expect(current_path).to eq user_registration_path
				expect(page).to have_content 'Eメールはすでに存在します'
			end
		end
	end

	describe 'ユーザー編集・削除' do
		context 'ユーザー編集画面でデータが正しく入力されている場合' do
			it 'ユーザー情報が編集され、ユーザー詳細画面に遷移すること' do
				login(user)
				click_on 'プロフィール'
				click_on '編集'
				fill_in 'ユーザー名', with: 'test_2'
				fill_in '現在のパスワード', with: user.password
				click_on '更新'
				expect(current_path).to eq user_path(user)
				expect(page).to have_content 'test_2'
			end
		end

		context 'ユーザー編集画面でパスワードが入力されていない場合' do
			it 'ユーザー情報の編集が失敗すること' do
				login(user)
				click_on 'プロフィール'
				click_on '編集'
				fill_in 'ユーザー名', with: 'test_2'
				fill_in '現在のパスワード', with: nil
				click_on '更新'
				expect(page).to have_content 'パスワードを入力してください'
			end
		end

		context 'ユーザー編集画面でアカウント削除をクリックした場合' do
			it 'ユーザー情報が削除され、トップページに遷移すること' do
				login(user)
				click_on 'プロフィール'
				click_on '編集'
				click_on 'アカウント削除'
				page.driver.browser.switch_to.alert.accept
				expect(current_path).to eq root_path
			end
		end
	end

	describe 'ログイン・ログアウト' do
		context 'データが正しく入力されている場合' do
			it '正しくログインされ、練習記録一覧画面に遷移すること' do
				login(user)
				expect(current_path).to eq practice_diaries_path
			end
		end

		context 'ログアウトボタンをクリックした場合' do
			it '正しくログアウトされ、トップページに遷移すること' do
				login(user)
				click_on 'ログアウト'
				expect(current_path).to eq root_path
			end
		end

		context 'ゲストログインボタンをクリックした場合' do
			it 'ゲストユーザーでログインし、練習記録一覧ページに遷移すること' do
				visit root_path
				click_on 'ゲストログイン', match: :first
				expect(page).to have_content 'ようこそ、guestさん'
			end
		end
	end
end