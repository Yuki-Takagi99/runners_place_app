require 'rails_helper'

RSpec.describe 'Notification', type: :system do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:jon) }
  let!(:diary) { create(:practice_diary, user_id: user.id) }
  let!(:event) { create(:event, user_id: user.id) }

  describe 'フォロー通知', js: true do
    context 'まだフォローしていないとき、ユーザ詳細画面でフォローするボタンをクリックした場合' do
      it 'フォローされたユーザーの通知一覧画面に通知が表示されること' do
        login(other_user)
        click_on 'みんなの記録', match: :first
        user = User.find_by(user_name: 'test_1')
        click_on user.user_name
        find('.btn-primary').click
        click_on 'ログアウト', match: :first
        login(user)
        click_on '通知'
        expect(page).to have_content 'jonさんがあなたをフォローしました！'
      end
    end
  end

  describe '練習記録のコメント通知', js: true do
    context '練習記録詳細画面でコメントを入力し、登録するボタンをクリックした場合' do
      it 'コメントされたユーザーの通知一覧画面に通知が表示されること' do
        login(other_user)
        click_on 'みんなの記録', match: :first
        click_on '詳細を見る', match: :first
        fill_in 'コメント', with: 'お疲れ様でした！'
        click_on '登録する'
        click_on 'ログアウト', match: :first
        login(user)
        click_on '通知'
        expect(page).to have_content 'jonさんが練習記録「test_title」にコメントしました！'
      end
    end
  end

  describe '練習記録のお気に入り', js: true do
    context 'まだお気に入りしていないとき、練習記録詳細画面で灰色のお気に入りアイコンをクリックした場合' do
      it 'いいねされたユーザーの通知一覧画面に通知が表示されること' do
        login(other_user)
        click_on 'みんなの記録', match: :first
        click_on '詳細を見る', match: :first
        find('.fav-btn').click
        click_on 'ログアウト', match: :first
        login(user)
        click_on '通知'
        expect(page).to have_content 'jonさんが練習記録「test_title」にいいね！しました！'
      end
    end
  end

  describe 'イベントのコメント通知', js: true do
    context 'イベント詳細画面でコメントを入力し、登録するボタンをクリックした場合' do
      it 'コメントされたユーザーの通知一覧画面に通知が表示されること' do
        login(other_user)
        click_on 'イベントを探す', match: :first
        click_on '定期練習会', match: :first
        fill_in 'コメント', with: 'どこに集合ですか？'
        click_on '登録する'
        click_on 'ログアウト', match: :first
        login(user)
        click_on '通知'
        expect(page).to have_content 'jonさんがイベント「定期練習会」にコメントしました！'
      end
    end
  end

  describe 'イベントの参加通知', js: true do
    context 'まだ参加申請をしていないとき、イベント詳細画面で参加するボタンをクリックした場合' do
      it '参加申請されたイベントの主催者ユーザーの通知一覧画面に通知が表示されること' do
        login(other_user)
        click_on 'イベントを探す', match: :first
        click_on '定期練習会', match: :first
        find('.btn-info').click
        click_on 'ログアウト', match: :first
        login(user)
        click_on '通知'
        expect(page).to have_content 'jonさんがイベント「定期練習会」に参加予定です！'
      end
    end
  end

  describe '通知削除', js: true do
    context '通知が表示されているとき、通知を削除ボタンをクリックした場合' do
      it '通知が削除されること' do
        login(other_user)
        click_on 'みんなの記録', match: :first
        user = User.find_by(user_name: 'test_1')
        click_on user.user_name
        find('.btn-primary').click
        click_on 'ログアウト', match: :first
        login(user)
        click_on '通知'
        click_on '通知を削除'
        expect(page).to have_content '通知はありません'
      end
    end
  end
end