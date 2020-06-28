require 'rails_helper'

RSpec.describe 'FriendShip', type: :system do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:jon) }
  let!(:diary) { create(:practice_diary, user_id: user.id) }

  describe 'ユーザのフォロー、フォロー解除', js: true do
    context 'まだフォローしていないとき、ユーザ詳細画面でフォローするボタンをクリックした場合' do
      it 'フォローするボタンがフォロー解除ボタンに変わること' do
        login(other_user)
        click_on 'みんなの記録', match: :first
        user = User.find_by(user_name: 'test_1')
        click_on user.user_name
        find('.btn-primary').click
        expect(page).to have_css '.btn-danger'
      end
    end

    context 'フォロー済みのとき、ユーザ詳細画面でフォロー解除ボタンをクリックした場合' do
      it 'フォロー解除ボタンがフォローするボタンに変わること' do
        login(other_user)
        click_on 'みんなの記録', match: :first
        user = User.find_by(user_name: 'test_1')
        click_on user.user_name
        find('.btn-primary').click
        find('.btn-danger').click
        expect(page).to have_css '.btn-primary'
      end
    end
  end
end