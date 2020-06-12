require 'rails_helper'

RSpec.describe PracticeComment, type: :model do
	describe 'バリデーションテスト' do
		before do
			@user = create(:user)
			@practice_diary = create(:practice_diary, user_id: @user.id)
			@practice_comment = create(:practice_comment, user_id: @user.id, practice_diary_id: @practice_diary.id)
		end
		it 'データがあれば有効であること' do
			expect(@practice_comment).to be_valid
    end

    it 'practice_comment_contentがなければ無効であること' do
      @practice_comment.practice_comment_content = nil
      expect(@practice_comment).not_to be_valid
    end

    it 'practice_comment_contentが151文字以上なら無効であること' do
      @practice_comment.practice_comment_content = "a" * 151
      expect(@practice_comment).not_to be_valid
    end

    it 'user_idがなければ無効であること' do
      @practice_comment.user_id = nil
      expect(@practice_comment).not_to be_valid
    end

    it 'practice_diary_idがなければ無効であること' do
      @practice_comment.practice_diary_id = nil
      expect(@practice_comment).not_to be_valid
    end
  end
end
