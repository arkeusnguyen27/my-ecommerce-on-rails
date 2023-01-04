class SellerMailer < ApplicationMailer

  def welcome_email
    @user = params[:user]
    @url  = 'http://localhost:3000'
    mail(to: @user.email, subject: 'Welcome to Judge.me')
  end

  def send_order_notification_email
    @seller = params[:seller]
    @order = params[:order]
    mail(to: @seller.email, subject: 'A buyer has placed an order on Judge.me')
  end
end
