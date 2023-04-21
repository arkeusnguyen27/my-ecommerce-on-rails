class BlogsController < ApplicationController
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
      @blogs = Blog.all
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
  
    private
    def blog_params
      params.require(:blog).permit(:title, :content)
      #Blog.find(params[:id])
    end
  end
  