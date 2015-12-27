require 'test_helper'

class CreateCategoriesTest < ActionDispatch::IntegrationTest
    
    def setup
        @category = Category.create(name: "books")
        @category2 = Category.create(name: "food")
        @category3 = Category.create(name: "lifestyle")
    end
    
    test "should show complete list" do
        get categories_path
        assert_template 'categories/index'
        assert_select 'a[href=?]', category_path(@category), text: @category.name
        assert_select 'a[href=?]', category_path(@category2), text: @category2.name
        assert_select 'a[href=?]', category_path(@category3), text: @category3.name
    end
    
end