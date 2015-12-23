class UsersController < ApplicationController

before_action :set_user, only: [:update, :edit, :show]

def index
end

def new
    @user = User.new
end

def show
    @posts = @user.posts
end

def edit
#    @user = User.find(params[:id])
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
    if @user.save
        flash[:success] = "User was created successfully"
        redirect_to posts_path
    else
        render 'new'
    end
end

private
    def set_user
        @user = User.find(params[:id])
    end
    def user_params
        params.require(:user).permit(:username, :email, :password)
    end
end