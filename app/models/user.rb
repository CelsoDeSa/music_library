class User < ApplicationRecord
    validates :username, uniqueness: true
    validates :full_name, :username, :password, :role, presence: true
    has_secure_password
    
end
