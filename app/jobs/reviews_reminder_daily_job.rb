class ReviewsReminderDailyJob
  include Sidekiq::Job
  def perform
    LineItem.where(reviewed_at: nil, retry_disabled: false).each do |li|
      if li.shop.sending_reminder_retry_count > li.retry_count
        ReviewerReminderEmailJob.perform_async(li.id)
      end
    end
  end

end