class RepliesController < ApplicationController

  def new
    @reply = Reply.new
  end

  def create
    #binding.pry
    @reply = Reply.new(reply_params.merge(user: current_user))
    blog = Comment.find(reply_params[:comment_id])
    
    if reply_params[:content].present?
      respond_to do |format|
        if @reply.save
          format.html { redirect_to blog_path(blog.blog_id), notice: "Reply was successfully created." }
          format.json { render :show, status: :created, location: @reply }
        else
          @path = blog_path
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @reply.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def edit
    @reply = Reply.find(params[:id])
  end

  def update
    #binding.pry
    @reply = Reply.find(params[:reply][:reply_id])
    respond_to do |format|
      if @reply.update(reply_params)
        format.html { redirect_to blog_path, notice: "Reply was successfully updated." }
        format.json { render :show, status: :ok, location: @reply }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end


  private
  def reply_params
    params.require(:reply).permit(:comment_id, :content)
  end
end
