class User < ApplicationRecord
    has_secure_password
    has_many :posts, dependent: :destroy
    has_many :comments, dependent: :destroy

    validates :email, presence: true, uniqueness: true
    validates :username, presence: true, uniqueness: true
    validates :password, presence: true, length: { minimum: 6 }

    has_one_attached :avatar

    has_and_belongs_to_many :liked_posts, class_name: "Post"
end
