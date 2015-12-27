class CategoriesController < ApplicationController
    
    before_action :require_admin_user, except: [:index, :show]
    
    def index
        @categories = Category.paginate(page: params[:page], per_page: 25)
    end
    
    def new
        @category = Category.new
    end
    
    def create 
        @category = Category.new(category_params)
        if @category.save
            flash[:success] = "The category was successfully created"
            redirect_to categories_path
        else
            render 'new'
        end
    end
    
    def show
        
    end
    
    private
        def category_params
            params.require(:category).permit(:name)
        end
        
        def require_admin_user
            if !logged_in? || !current_user.is_admin
                flash[:danger] = "You do not have access to category management"
                redirect_to root_path
            end
        end
    
end