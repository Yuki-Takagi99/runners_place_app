require 'rails_helper'
RSpec.describe PracticeDiary, type: :model do
	describe 'バリデーションテスト' do
		it 'practice_titleが空なら保存されないこと' do
    	practice_diary = PracticeDiary.new(practice_title: '', practice_content: '失敗テスト', practice_distance: 5.0)
    	expect(practice_diary).not_to be_valid
		end
		it 'practice_contentが空なら保存されないこと' do
    	practice_diary = PracticeDiary.new(practice_title: '失敗テスト', practice_content: '', practice_distance: 5.0)
    	expect(practice_diary).not_to be_valid
		end
		it 'practice_distanceが空なら保存されないこと' do
    	practice_diary = PracticeDiary.new(practice_title: '失敗テスト', practice_content: '失敗テスト', practice_distance: '')
    	expect(practice_diary).not_to be_valid
		end
	end
end