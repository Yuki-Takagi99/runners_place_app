require 'rails_helper'

RSpec.describe 'PracticeComment', type: :system do
	let!(:user) { create(:user) }
	let!(:other_user) { create(:jon) }
	let!(:diary) { create(:practice_diary, user_id: user.id) }

	describe '練習記録のコメント作成', js: true do
		context '練習記録詳細画面でコメントを入力し、登録するボタンをクリックした場合' do
			it 'コメントが作成されること' do
				login(other_user)
				click_on 'みんなの記録', match: :first
        click_on '詳細を見る', match: :first
        fill_in 'コメント', with: 'お疲れ様でした！'
				click_on '登録する'
				expect(page).to have_content '1件のコメントがあります！'
			end
    end

    context '練習記録詳細画面でコメントが未入力の場合、' do
			it 'コメントの作成が失敗すること' do
				login(other_user)
				click_on 'みんなの記録', match: :first
        click_on '詳細を見る', match: :first
        fill_in 'コメント', with: ''
				click_on '登録する'
				expect(page).to have_content 'まだコメントはありません！'
			end
		end
  end

  describe 'コメントの編集・削除', js: true do
		context 'コメントの編集画面でデータが正しく入力されている場合' do
			it 'コメントが編集できること' do
				login(other_user)
				click_on 'みんなの記録', match: :first
        click_on '詳細を見る', match: :first
        fill_in 'コメント', with: 'お疲れ様でした！'
				click_on '登録する'
        click_on 'コメント編集'
        # 編集のtext_areaを指定
        find(".materialize-textarea").set("応援してます！")
        click_on '送信'
        expect(page).to have_content '1件のコメントがあります！'
        expect(page).to have_content '応援してます！'
			end
    end

    context 'コメント削除をクリックした場合' do
			it 'コメントが削除されること' do
				login(other_user)
				click_on 'みんなの記録', match: :first
        click_on '詳細を見る', match: :first
        fill_in 'コメント', with: 'お疲れ様でした！'
				click_on '登録する'
        click_on 'コメント削除'
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content 'まだコメントはありません！'
			end
    end

    context '他ユーザーのコメントを参照した場合' do
			it '編集・削除ボタンが表示されないこと' do
				login(other_user)
				click_on 'みんなの記録', match: :first
        click_on '詳細を見る', match: :first
        fill_in 'コメント', with: 'お疲れ様でした！'
        click_on '登録する'
        click_on 'ログアウト'
        # 他ユーザーでログイン
        login(user)
        click_on '詳細を見る', match: :first
        expect(page).not_to have_content 'コメント編集'
        expect(page).not_to have_content 'コメント削除'
			end
    end
	end
end