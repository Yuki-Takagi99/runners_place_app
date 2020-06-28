require 'rails_helper'

RSpec.describe 'PracticeFavorite', type: :system do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:jon) }
  let!(:diary) { create(:practice_diary, user_id: user.id) }

  describe '練習記録のお気に入り', js: true do
    context 'まだお気に入りしていないとき、練習記録詳細画面で灰色のお気に入りアイコンをクリックした場合' do
      it 'お気に入りアイコンの表示が赤色に変わること' do
        login(other_user)
        click_on 'みんなの記録', match: :first
        click_on '詳細を見る', match: :first
        find('.fav-btn').click
        expect(page).to have_css '.fav-btn-on'
      end
    end

    context 'お気に入り済みのとき、練習記録詳細画面で赤色のお気に入りアイコンをクリックした場合' do
      it 'お気に入りアイコンの表示が灰色に変わること' do
        login(other_user)
        click_on 'みんなの記録', match: :first
        click_on '詳細を見る', match: :first
        find('.fav-btn').click
        find('.fav-btn-on').click
        expect(page).to have_css '.fav-btn'
      end
    end

    context 'まだお気に入りしていないとき、みんなの記録画面で灰色のお気に入りアイコンをクリックした場合' do
      it 'お気に入りアイコンの表示が赤色に変わること' do
        login(other_user)
        click_on 'みんなの記録', match: :first
        find('.fav-btn').click
        expect(page).to have_css '.fav-btn-on'
      end
    end

    context 'お気に入り済みのとき、みんなの記録画面で赤色のお気に入りアイコンをクリックした場合' do
      it 'お気に入りアイコンの表示が灰色に変わること' do
        login(other_user)
        click_on 'みんなの記録', match: :first
        find('.fav-btn').click
        find('.fav-btn-on').click
        expect(page).to have_css '.fav-btn'
      end
    end
  end
end
