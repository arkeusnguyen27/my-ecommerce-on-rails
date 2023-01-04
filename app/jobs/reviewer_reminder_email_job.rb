class ReviewerReminderEmailJob
  include Sidekiq::Job
  def perform(line_item_id)
    @line_item = LineItem.find_by(id: line_item_id, reviewed_at: nil)
    return unless @line_item.present?

    # check retry count
    return if @line_item.shop.sending_reminder_retry_count <= @line_item.retry_count

    # send email
    BuyerMailer.with(line_item_id: line_item_id).reminder_request_to_review_email.deliver_later

    # increment count
    if @line_item.retry_count + 1 == @line_item.shop.sending_reminder_retry_count
      @line_item.retry_count += 1
      @line_item.retry_disabled = true
      @line_item.save
    else
      @line_item.increment!(:retry_count)
    end

  end

end