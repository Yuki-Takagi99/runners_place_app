require 'rails_helper'

RSpec.describe 'Event', type: :system do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }

  describe 'イベントの作成', js: true do
    context 'データが正しく入力されている場合' do
      it 'イベントが作成でき、イベント詳細画面に遷移すること' do
        login(user)
        click_on 'イベントを登録する', match: :first
        fill_in '開催日時', with: Date.today + 7
        fill_in 'イベント名', with: '定期練習会'
        fill_in 'イベント内容', with: '第1回定期練習会を開催します。'
        fill_in '最小催行人数', with: '2'
        fill_in '開催場所', with: '井の頭公園'
        click_on '登録する'
        event = Event.find_by(event_title: '定期練習会')
        expect(current_path).to eq event_path(event)
        expect(page).to have_content '定期練習会'
      end
    end

    context 'イベントが本日以前の日付の場合' do
      it 'イベントの作成が失敗すること' do
        login(user)
        click_on 'イベントを登録する', match: :first
        fill_in '開催日時', with: Date.today - 7
        fill_in 'イベント名', with: '定期練習会'
        fill_in 'イベント内容', with: '第1回定期練習会を開催します。'
        fill_in '最小催行人数', with: '2'
        fill_in '開催場所', with: '井の頭公園'
        click_on '登録する'
        expect(page).to have_content '開催日時は本日以降の日付を選択してください'
      end
    end

    context 'イベント名が未入力の場合' do
      it 'イベントの作成が失敗すること' do
        login(user)
        click_on 'イベントを登録する', match: :first
        fill_in '開催日時', with: Date.today + 7
        fill_in 'イベント名', with: ''
        fill_in 'イベント内容', with: '第1回定期練習会を開催します。'
        fill_in '最小催行人数', with: '2'
        fill_in '開催場所', with: '井の頭公園'
        click_on '登録する'
        expect(page).to have_content 'イベント名を入力してください'
      end
    end
  end

  describe 'イベントの編集・削除', js: true do
    before do
      login(user)
      click_on 'イベントを登録する', match: :first
      fill_in '開催日時', with: Date.today + 7
      fill_in 'イベント名', with: '定期練習会'
      fill_in 'イベント内容', with: '第1回定期練習会を開催します。'
      fill_in '最小催行人数', with: '2'
      fill_in '開催場所', with: '井の頭公園'
      click_on '登録する'
    end

    context 'イベントの編集画面でデータが正しく入力されている場合' do
      it 'イベントが編集され、イベント詳細画面に遷移すること' do
        # 編集アイコンをクリック
        find('.fa-edit').click
        fill_in 'イベント内容', with: '第2回定期練習会を開催します。'
        click_on '更新する'
        event = Event.find_by(event_content: '第2回定期練習会を開催します。')
        expect(current_path).to eq event_path(event)
        expect(page).to have_content 'イベントを編集しました！'
        expect(page).to have_content '第2回定期練習会を開催します。'
      end
    end

    context 'イベント詳細画面で削除アイコンをクリックした場合' do
      it 'イベントが削除され、イベント一覧画面に遷移すること' do
        # 削除アイコンをクリック
        find('.fa-trash').click
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content 'これから開催されるイベントは0件です！'
        expect(current_path).to eq events_path
      end
    end
  end

  describe 'イベントの表示', js: true do
    before do
      login(user)
      click_on 'イベントを登録する', match: :first
      fill_in '開催日時', with: Date.today + 7
      fill_in 'イベント名', with: '定期練習会'
      fill_in 'イベント内容', with: '第1回定期練習会を開催します。'
      fill_in '最小催行人数', with: '2'
      fill_in '開催場所', with: '井の頭公園'
      click_on '登録する'
    end

    context 'イベント一覧画面でイベント名をクリックした場合' do
      it 'イベント詳細画面に遷移すること' do
        visit events_path
        event = Event.find_by(event_title: '定期練習会')
        click_on '定期練習会', match: :first
        expect(current_path).to eq event_path(event)
      end
    end
  end
end