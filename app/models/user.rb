class User < ApplicationRecord
    has_secure_password  # add funcionalidad to  contraseñas seguras (usa bcrypt)

     has_many :posts
     has_many :comments
end
