class WeeklyMailer < ActionMailer::Base
  default from: '"Weekly Summary" <no-reply@fonix.com>'

  def weekly_summary(user_id, last_messaged_at, user_messages_count, last_week_count)
    @user = User.find(user_id)
    @last_messaged_at = Time.parse(last_messaged_at)
    @user_messages_count = user_messages_count
    @last_week_count = last_week_count

    mail(to: @user.email, subject: 'Weekly Messages Report')
  end
end
