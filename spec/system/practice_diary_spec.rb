require 'rails_helper'

RSpec.describe 'PracticeDiary', type: :system do
	let!(:user) { create(:user) }
	let!(:other_user) { create(:user) }

	describe '練習記録の作成' do
		context 'データが正しく入力されている場合' do
			it '練習記録が作成でき、練習記録詳細画面に遷移すること' do
				login(user)
				click_on '記録をつける', match: :first
				fill_in '練習日', with: Date.today - 1
				fill_in 'タイトル', with: 'ジョギング'
				fill_in '詳細', with: 'ゆっくり走りました！'
				fill_in '走行距離', with: '10.0'
				select_time("01", "00", "30", from: "走行時間")
				click_on '登録する'
				expect(page).to have_content 'ジョギング'
			end
		end
	end
end
