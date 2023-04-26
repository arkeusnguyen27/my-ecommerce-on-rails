class CommentsController < ApplicationController

    def new
      @comment = Comment.new
    end

    def create
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
    def comment_params
      params.require(:comment).permit(:content, :blog_id)
    end
  end
  