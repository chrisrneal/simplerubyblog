class Post < ActiveRecord::Base
    validates :title, presence: true
    validates :description, presence: true
    validates :user_id, presence: true
    belongs_to :user
    has_many :post_categories
    has_many :categories, through: :post_categories
end