class WeeklyMailerWorker
  include Sidekiq::Worker

  def perform(user_id, last_messaged_at, last_week_count)
    user_messages_count = Message.where("created_at > ?", Time.parse(last_messaged_at) + 1.second).count

    WeeklyMailer.weekly_summary(
      user_id,
      last_messaged_at,
      user_messages_count,
      last_week_count
    ).deliver_now
  end
end
