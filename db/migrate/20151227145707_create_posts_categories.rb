class CreatePostsCategories < ActiveRecord::Migration
  def change
    create_table :posts_categories do |t|
      t.integer :post_id
      t.integer :category_id
    end
  end
end
