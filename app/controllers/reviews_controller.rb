class ReviewsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create_by_email]
  before_action :authenticate_user!, except: [:create_by_email]
  def create
    if review_params[:line_item_id].present?
      line_item = LineItem.where(id: review_params[:line_item_id], buyer: current_user).where(reviewed_at: nil).first
    else
      line_item = LineItem.where(product_id: review_params[:product_id], buyer: current_user).where(reviewed_at: nil).first
    end


    respond_to do |format|
      unless line_item.present?
        format.html { redirect_to root_url, notice: "Don't mess with us" }
      end

      review = Review.new(
        line_item: line_item,
        user: current_user,
        title: review_params[:title],
        body: review_params[:body],
        rating: review_params[:rating]
      )

      if review.save
        line_item.update(reviewed_at: Time.now)
        format.html { redirect_to request.referrer, notice: "Your review has been recorded" }
      else
        format.html { redirect_to request.referrer, notice: "Something went wrong" }
      end

    end

  end

  def create_by_email
    token = review_params[:token]
    # validate token
    result = JWT.decode token, ENV['SECRET_KEY_BUYER_EMAIL'], true, { algorithm: 'HS256' }
    payload = result[0]
    user = User.find(payload['id'])

    line_item = LineItem.where(id: review_params[:line_item_id], buyer: user).where(reviewed_at: nil).first

    respond_to do |format|
      unless line_item.present?
        format.html { redirect_to root_url, notice: "Don't mess with us" }
      end

      review = Review.new(
        line_item: line_item,
        user: user,
        title: review_params[:title],
        body: review_params[:body],
        rating: review_params[:rating]
      )

      if review.save
        line_item.update(reviewed_at: Time.now)
        format.html { redirect_to request.referrer, notice: "Your review has been recorded" }
      else
        format.html { redirect_to request.referrer, notice: "Something went wrong" }
      end

    end

  end

  private
  def review_params
    params.require(:review).permit(:title, :body, :line_item_id, :product_id, :rating, :token)
  end
end