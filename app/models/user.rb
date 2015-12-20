class User < ActiveRecord::Base
    has_many :posts
    before_save { 
        self.email = email.downcase
        self.username = username.downcase
    }
    validates :username, presence: true, uniqueness: {case_sensitive: false}, length: {minimum:3, maximum:30}
    validates :email, presence: true, uniqueness: {case_sensitive: false} 
    validates_format_of :email, :with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
    has_secure_password
end