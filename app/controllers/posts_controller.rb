class PostsController < ApplicationController

    before_action :set_article, only: [:edit, :update, :destroy, :show]
    before_action :require_user, except: [:show, :index]
    before_action :require_spec_user, only: [:edit, :update, :destroy]

    def index
        @posts = Post.paginate(page: params[:page], per_page: 5)
    end

    def new
        @post = Post.new
    end
    
    def create
        @post = Post.new(post_parms)
        @post.user = current_user
        if @post.save
            flash[:success] = "Article was successfully created"
            redirect_to post_path(@post)
        else
            render 'new'
        end
    end
    
    def update
        # @post = Post.find(params[:id])
        if @post.update(post_parms)
            flash[:success] = "Article was updated successfully"
            redirect_to post_path(@post)
        else
            render :new
        end
    end
    
    def destroy
        # @post = Post.find(params[:id])
        flash[:danger] = @post.destroy ? "Article was successfully deleted" : "Article did not delete."
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
        def require_spec_user
            if @post.user == current_user || current_user.is_admin
                return
            end
            
            flash[:danger] = "You do not have access to this feature"
            redirect_to posts_path
        end

end