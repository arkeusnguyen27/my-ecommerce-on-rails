class CommentsController < ApplicationController

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

    def edit
      @comment = Comment.find(params[:id])
    end

    def update
      #binding.pry
      @comment = Comment.find(params[:comment][:comment_id])
      respond_to do |format|
        if @comment.update(comment_params)
          format.html { redirect_to blog_path, notice: "Comment was successfully updated." }
          format.json { render :show, status: :ok, location: @comment }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @comment.errors, status: :unprocessable_entity }
        end
      end
    end


    private
    def comment_params
      params.require(:comment).permit(:blog_id, :content)
    end
  end
  