require 'rails_helper'

RSpec.describe 'ParticipantManagement', type: :system do
	let!(:user) { create(:user) }
	let!(:other_user) { create(:jon) }
	let!(:event) { create(:event, user_id: user.id) }

	describe 'イベントの参加申請・キャンセル', js: true do
		context 'まだ参加申請をしていないとき、イベント詳細画面で参加するボタンをクリックした場合' do
			it '参加するボタンがキャンセルボタンに変わること' do
				login(other_user)
				click_on 'イベントを探す', match: :first
				click_on '定期練習会', match: :first
				find('.btn-info').click
				expect(page).to have_content 'キャンセル'
				expect(page).to have_css '.btn-danger'
			end
		end

		context '参加申請済みのとき、イベント詳細画面でキャンセルボタンをクリックした場合' do
			it 'キャンセルボタンが参加するボタンに変わること' do
				login(other_user)
				click_on 'イベントを探す', match: :first
				click_on '定期練習会', match: :first
				find('.btn-info').click
				find('.btn-danger').click
				expect(page).to have_css '.btn-info'
			end
		end
	end
end
