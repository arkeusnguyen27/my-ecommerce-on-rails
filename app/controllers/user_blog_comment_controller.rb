class UserBlogCommentController < ApplicationController

  def new
    @comment = Comment.new
  end

  def create
    #binding.pry 
    @comment = Comment.new(comment_params.merge(user: current_user, blog: @blog))
    @comment.blog_id = comment_params[:blog_id]
    
    if comment_params[:content].present?
      respond_to do |format|
        if @comment.save
          format.html { redirect_to blog_path(@comment.blog_id), notice: "Comment was successfully created." }
          format.json { render :show, status: :created, location: @comment }
        else
          @path = blog_path
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @comment.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def show
    @comment = comment_params
  end

  def edit
    #binding.pry
    @path = user_blog_path
    @comment = Comment.find(params[:id])
  end

  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to user_blog_index_path, notice: "Comment was successfully updated." }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def create_new_form_path
    @path = blog_user_blog_comment_path
  end

  def create_edit_form_path
    @path = blog_user_blog_comment_path
  end

  def destroy
  end

  private
    def comment_params
      params.require(:comment).permit(:blog_id, :content)
    end
end
