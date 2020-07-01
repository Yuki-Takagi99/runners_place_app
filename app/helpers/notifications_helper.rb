module NotificationsHelper
  def notification_form(notification)
    #通知を送ってきたユーザーを取得
    @visitor = notification.visitor
    #コメントの内容を通知に表示する
    @practice_comment = nil
    @visitor_comment = notification.practice_comment_id
    # notification.actionがfollowかfavoriteかcommentかで処理を変える
    case notification.action
    when 'follow'
      #aタグで通知を作成したユーザーshowのリンクを作成
      tag.a(notification.visitor.user_name, href: user_path(@visitor)) + 'さんがあなたをフォローしました！'
    when 'favorite'
      tag.a(notification.visitor.user_name, href: user_path(@visitor)) + 'さんが' + tag.a("#{notification.practice_diary.practice_title}", href: practice_diary_path(notification.practice_diary_id)) + 'にいいね！しました！'
    when 'comment' then
      #コメントの内容と投稿のタイトルを取得
      @practice_comment = PracticeComment.find_by(id: @visitor_comment)
      @practice_comment_content = @practice_comment.practice_comment_content
      @practice_diary_title = @practice_comment.practice_diary.practice_title
      tag.a(@visitor.user_name, href: user_path(@visitor)) + 'さんが' + tag.a("#{@practice_diary_title}", href: practice_diary_path(notification.practice_diary_id)) + 'にコメントしました！'
    end
  end
  # 未確認の通知がある場合に通知マークを表示
  def unchecked_notifications
    @notifications = current_user.passive_notifications.where(checked: false)
  end
end
