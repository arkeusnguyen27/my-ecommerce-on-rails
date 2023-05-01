class BlogsController < ApplicationController

  skip_before_action :verify_authenticity_token, only: [:increase_view_count]
    def new
      @blog = Blog.new
    end

    def create
      @blog = Blog.new(blog_params.merge(user: current_user))
      
      if blog_params[:content].present?
        respond_to do |format|
          if @blog.save
            format.html { redirect_to user_blog_index_path, notice: "Blog was successfully created." }
            format.json { render :show, status: :created, location: @blog }
          else
            @path = user_blog_path
            format.html { render :new, status: :unprocessable_entity }
            format.json { render json: @blog.errors, status: :unprocessable_entity }
          end
        end
      end
    end

    def index
      #@blogs = Blog.all
      @q = Blog.ransack(params[:q])
      @blogs = @q.result(distinct: true)
    end
  
    def show
      @blog = Blog.find(params[:id]) or not_found
    end

    def edit

    end

    def update
      respond_to do |format|
        if @blog.update(blog_params)
          format.html { redirect_to user_blog_index_path, notice: "Blog was successfully updated." }
          format.json { render :show, status: :ok, location: @blog }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @blog.errors, status: :unprocessable_entity }
        end
      end
    end

    def increase_view_count
      blog = Blog.find(params[:id])
      blog.update_attribute(:view_count, blog.view_count + 1)
      render json: {
        status: 'ok'
      }
    end

    def sort
      
    end

    private
    def blog_params
      params.require(:blog).permit(:title, :content)
    end
  end
  