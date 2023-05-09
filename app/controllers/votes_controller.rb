class VotesController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:update_vote]

  def create
    #binding.pry
    @vote = Vote.new(vote_params.merge(user: current_user))
    if vote_params[:blog_id].present?
      respond_to do |format|
        if @vote.save
          format.html { redirect_to blog_path(@vote.blog_id), notice: "Vote was successfully created." }
          format.json { render :show, status: :created, location: @vote }
        else
          @path = blog_path
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @vote.errors, status: :unprocessable_entity }
        end
      end
    end
  end


  def update
    #binding.pry
    @vote = Vote.where(:blog_id => vote_params[:blog_id], :user_id => current_user)
    respond_to do |format|
      if @vote.update(vote_params)
        format.html { redirect_to blog_path(vote_params[:blog_id]), notice: "Vote was successfully updated." }
        format.json { render :show, status: :ok, location: @vote }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_vote
    #binding.pry
    is_vote_existed_before = Vote.where(:blog_id => vote_params[:blog_id], :user_id => current_user)
    if is_vote_existed_before.present?
      update
    else
      create
    end
  end

  private
  def vote_params
    params.require(:vote).permit(:blog_id, :react)
  end
end
