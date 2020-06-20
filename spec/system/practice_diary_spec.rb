require 'rails_helper'

RSpec.describe 'PracticeDiary', type: :system do
	let!(:user) { create(:user) }
	let!(:other_user) { create(:user) }

	describe '練習記録の作成' do
		context 'データが正しく入力されている場合' do
			it '練習記録が作成でき、練習記録詳細画面に遷移すること' do
				login(user)
				click_on '記録をつける', match: :first
				fill_in '練習日', with: Date.today
				fill_in 'タイトル', with: 'ジョギング'
				fill_in '詳細', with: 'ゆっくり走りました！'
				fill_in '走行距離', with: '10.0'
				select_time("01", "00", "30", from: "走行時間")
				click_on '登録する'
				practice_diary = PracticeDiary.find_by(practice_title: 'ジョギング')
				expect(current_path).to eq practice_diary_path(practice_diary)
				expect(page).to have_content 'ジョギング'
			end
		end

		context '練習日が本日以降の日付の場合' do
			it '練習記録の作成が失敗すること' do
				login(user)
				click_on '記録をつける', match: :first
				fill_in '練習日', with: Date.today + 1
				fill_in 'タイトル', with: nil
				fill_in '詳細', with: 'ゆっくり走りました！'
				fill_in '走行距離', with: '10.0'
				select_time("01", "00", "30", from: "走行時間")
				click_on '登録する'
				expect(page).to have_content '練習日は本日以前の日付を選択してください'
			end
		end

		context 'タイトルが未入力の場合' do
			it '練習記録が作成が失敗すること' do
				login(user)
				click_on '記録をつける', match: :first
				fill_in '練習日', with: Date.today - 1
				fill_in 'タイトル', with: nil
				fill_in '詳細', with: 'ゆっくり走りました！'
				fill_in '走行距離', with: '10.0'
				select_time("01", "00", "30", from: "走行時間")
				click_on '登録する'
				expect(page).to have_content 'タイトルを入力してください'
			end
		end
	end

	describe '練習記録の編集・削除' do
		before do
			login(user)
				click_on '記録をつける', match: :first
				fill_in '練習日', with: Date.today
				fill_in 'タイトル', with: 'ジョギング'
				fill_in '詳細', with: 'ゆっくり走りました！'
				fill_in '走行距離', with: '10.0'
				select_time("01", "00", "30", from: "走行時間")
				click_on '登録する'
		end
		context '練習記録の編集画面でデータが正しく入力されている場合' do
			it '練習記録が編集され、練習記録詳細画面に遷移すること' do
				# 編集アイコンをクリック
				find('.glyphicon-pencil').click
				fill_in 'タイトル', with: 'ジョグ'
				click_on '更新する'
				practice_diary = PracticeDiary.find_by(practice_title: 'ジョグ')
				expect(current_path).to eq practice_diary_path(practice_diary)
				expect(page).to have_content '練習記録を編集しました！'
				expect(page).to have_content 'ジョグ'
			end
		end

		context '練習記録詳細画面で削除アイコンをクリックした場合' do
			it '練習記録が削除され、練習記録一覧画面に遷移すること' do
				# 削除アイコンをクリック
				find('.glyphicon-trash').click
				page.driver.browser.switch_to.alert.accept
				expect(page).to have_content '練習記録を削除しました！'
				expect(current_path).to eq practice_diaries_path
			end
		end
	end

	describe '練習記録の表示' do
		before do
			login(user)
			click_on '記録をつける', match: :first
			fill_in '練習日', with: Date.today
			fill_in 'タイトル', with: 'ジョギング'
			fill_in '詳細', with: 'ゆっくり走りました！'
			fill_in '走行距離', with: '10.0'
			select_time("01", "00", "30", from: "走行時間")
			click_on '登録する'
		end

		context '練習記録一覧画面で詳細を見るをクリックした場合' do
			it '練習記録詳細画面に遷移すること' do
				visit practice_diaries_path
				practice_diary = PracticeDiary.find_by(practice_title: 'ジョギング')
				click_on '詳細を見る', match: :first
				expect(current_path).to eq practice_diary_path(practice_diary)
			end
		end
	end
end
