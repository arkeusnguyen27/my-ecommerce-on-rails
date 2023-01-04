class BuyerMailer < ApplicationMailer

  def first_request_to_review_email
    @order = Order.find(params[:order_id])
    @buyer = @order.user
    # encode token
    @token = JWT.encode({id: @buyer.id}, ENV['SECRET_KEY_BUYER_EMAIL'], 'HS256')
    mail(to: @buyer.email, subject: 'Earn $10.000 when reviewing these products')
  end

  def reminder_request_to_review_email
    @line_item = LineItem.find(params[:line_item_id])
    @buyer = @line_item.buyer
    @token = JWT.encode({id: @buyer.id}, ENV['SECRET_KEY_BUYER_EMAIL'], 'HS256')
    mail(to: @buyer.email, subject: 'Reminder to review our products')
  end
end
