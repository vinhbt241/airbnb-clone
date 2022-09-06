class User < ApplicationRecord
  rolify :role_cname => 'Owner'
  rolify :role_cname => 'Admin'
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
