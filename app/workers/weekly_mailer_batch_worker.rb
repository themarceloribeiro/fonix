class WeeklyMailerBatchWorker
  include Sidekiq::Worker

  def perform
    # Last week count is the same for everyone so let's save the DB
    last_week_count = Message.where(created_at: 1.week.ago..Time.now).count

    User.includes(:messages).find_in_batches.each do |batch|
      batch.each do |user|
        last_messaged_at = user.messages.order(created_at: :desc).first.try(:created_at) || Time.now
        WeeklyMailerWorker.perform_async(user.id, last_messaged_at, last_week_count)
      end
    end
  end
end
