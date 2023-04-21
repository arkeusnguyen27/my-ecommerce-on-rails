class UserBlogController < ApplicationController

  def new
    @blog = Blog.new
  end

  def create
    @blog = Blog.new
    
    respond_to do |format|
      if @blog.save
        format.html { redirect_to user_blog_index_path, notice: "Blog was successfully created." }
        format.json { render :show, status: :created, location: @blog }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @blog = blog_params or not_found
  end

  def edit
    @path = user_blog_path
    @blog = Blog.find(params[:id])
  end

  def update
    @blog = Blog.find(params[:id])
    respond_to do |format|
      if @blog.update(blog_params)
        format.html { redirect_to user_blog_index_path, notice: "Blog was successfully updated." }
        format.json { render :show, status: :ok, location: @blog }
      else
        @path = user_blog_path
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  def create_new_form_path
    @path = user_blog_path
  end

  def create_edit_form_path
    @path = user_blog_path
  end

  def destroy
  end

  private
    def blog_params
      params.require(:blog).permit(:title, :content)
      #Blog.find(params[:id])
    end
end
