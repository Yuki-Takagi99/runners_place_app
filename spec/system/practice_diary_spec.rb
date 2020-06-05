require 'rails_helper'
RSpec.describe "練習記録管理機能", type: :system do
	describe '練習記録一覧画面' do
		context '練習記録を作成した場合' do
			it '作成した練習記録が表示されること' do
				practice_diary = FactoryBot.create(:practice_diary)
				visit practice_diaries_path
				expect(page).to have_content '練習記録一覧画面'
			end
		end
	end
end
