module NotificationsHelper
  def notification_form(notification)
    #通知を送ってきたユーザーを取得
    @visitor = notification.visitor
    #コメントの内容を通知に表示する
    @practice_comment = nil
    @event_comment = nil
    @visitor_practice_comment = notification.practice_comment_id
    @visitor_event_comment = notification.event_comment_id
    # notification.actionがfollowかfavoriteかcommentかevent_commentかで処理を変える
    case notification.action
    when 'follow'
      #aタグで通知を作成したユーザーshowのリンクを作成
      tag.a(notification.visitor.user_name, href: user_path(@visitor)) + 'さんがあなたをフォローしました！'
    when 'favorite'
      tag.a(notification.visitor.user_name, href: user_path(@visitor)) + 'さんが' + tag.a("#{notification.practice_diary.practice_title}", href: practice_diary_path(notification.practice_diary_id)) + 'にいいね！しました！'
    when 'comment' then
      #練習記録コメントの内容と投稿のタイトルを取得
      @practice_comment = PracticeComment.find_by(id: @visitor_practice_comment)
      @practice_comment_content = @practice_comment.practice_comment_content
      @practice_diary_title = @practice_comment.practice_diary.practice_title
      tag.a(@visitor.user_name, href: user_path(@visitor)) + 'さんが' + tag.a("#{@practice_diary_title}", href: practice_diary_path(notification.practice_diary_id)) + 'にコメントしました！'
    when "event_comment" then
      #イベントコメントの内容と投稿のタイトルを取得
      @event_comment = EventComment.find_by(id: @visitor_event_comment)
      @event_comment_content = @event_comment.event_comment_content
      @event_title = @event_comment.event.event_title
      tag.a(@visitor.user_name, href: user_path(@visitor)) + 'さんが' + tag.a("#{@event_title}", href: event_path(notification.event_id)) + 'にコメントしました！'
    end
  end
  # 未確認の通知がある場合に通知の文字を変えるためにチェック
  def unchecked_notifications
    @notifications = current_user.passive_notifications.where(checked: false)
  end
end
