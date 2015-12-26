class UsersController < ApplicationController

before_action :set_user, only: [:update, :edit, :show, :destroy]
before_action :require_user, except: [:create, :new, :destroy]
before_action :require_spec_user, only: [:edit, :update, :destroy]

def index
    @users = User.paginate(page: params[:page], per_page: 25)
end

def new
    @user = User.new
end

def show
    @posts = @user.posts.paginate(page: params[:page], per_page: 5)
end

def edit
#    @user = User.find(params[:id])
end

def destroy
    if @user == current_user
        session[:user_id] = nil
    end
    flash[:danger] = @user.destroy ? "User was successfully deleted" : "User was not deleted"
    redirect_to users_path
end

def update
#    @user = User.find(params[:id])
    if @user.update(user_params)
        flash[:success] = "User was updated successfully"
        redirect_to posts_path
    else
        render 'edit'
    end
end

def create
    @user = User.new(user_params)
    @user.is_admin = false
    if @user.save
        flash[:success] = "User was created successfully"
        session[:user_id] = @user.id
        redirect_to user_path(@user)
    else
        render 'new'
    end
end

private
    def set_user
        @user = User.find(params[:id])
    end
    def user_params
        params.require(:user).permit(:username, :email, :password, :is_admin)
    end
    def require_spec_user
        if @user == current_user || current_user.is_admin
            return
        end
        
        flash[:danger] = "You do not have access to this feature"
        redirect_to posts_path
    end
end