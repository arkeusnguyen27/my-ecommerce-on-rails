class BlogsController < ApplicationController

    def index
      @blogs = Blog.all
    end
  
    def show
      @blogs = blog_params or not_found
    end
  
    def update
    end
  
    private
    def blog_params
      Blog.find(params[:id])
    end
  end
  