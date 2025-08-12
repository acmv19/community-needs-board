class User < ApplicationRecord
    has_secure_password  # add funcionalidad to  contraseñas seguras (usa bcrypt)

     has_many :posts
     has_many :comments

     validates :name, presence: true
     validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
     validates :password, presence: true
end
