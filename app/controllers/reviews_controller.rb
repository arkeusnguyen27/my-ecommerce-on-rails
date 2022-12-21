class ReviewsController < ApplicationController
  before_action :authenticate_user!
  def create
    if review_params[:line_item_id].present?
      line_item = LineItem.where(id: review_params[:line_item_id], buyer: current_user).where.not(reviewed_at: nil).first
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

  private
  def review_params
    params.require(:review).permit(:title, :body, :line_item_id, :product_id, :rating)
  end
end