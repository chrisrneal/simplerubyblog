class PostsController < ApplicationController

    before_action :set_article, only: [:edit, :update, :destroy, :show]

    def index
        @posts = Post.all
    end

    def new
        @post = Post.new
    end
    
    def create
        @post = Post.new(post_parms)
        if @post.save
            flash[:notice] = "Article was successfully created"
            redirect_to post_path(@post)
        else
            render 'new'
        end
    end
    
    def update
        # @post = Post.find(params[:id])
        if @post.update(post_parms)
            flash[:notice] = "Article was updated successfully"
            redirect_to post_path(@post)
        else
            render :new
        end
    end
    
    def destroy
        # @post = Post.find(params[:id])
        flash[:notice] = @post.destroy ? "Article was successfully deleted" : "Article did not delete."
        redirect_to posts_path
    end
    
    def show
        # @post = Post.find(params[:id])
    end
    
    def edit
        # @post = Post.find(params[:id])
    end
    
    private
        def set_article
            @post = Post.find(params[:id])
        end
        def post_parms
            params.require(:post).permit(:title, :description)
        end

end