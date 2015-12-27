require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase

    def setup
        @category = Category.create(name: "sports")
        @user = User.create(username: "test", email: "test@example.com", password: "boo", is_admin: true)
    end

    test "should get categories index" do
        get :index
        assert_response :success
    end
    
    test "should get new category" do
        session[:user_id] = @user.id
        get :new
        assert_response :success
    end
    
    test "should get show" do
        get(:show, {'id' => @category.id})
        assert_response :success
    end

    test "should redirect when admin is not logged in" do
        assert_no_difference 'Category.count' do
            post :create, category: {name:"books"}
        end
        assert_redirected_to root_path
    end

end