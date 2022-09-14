class User < ApplicationRecord
  rolify :role_cname => 'Owner'
  rolify :role_cname => 'Admin'
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :trackable

  has_many :properties, foreign_key: "owner_id", dependent: :destroy

  has_many :reservations, dependent: :destroy
  has_many :reserved_properties, through: :reservations, source: :property

  pay_customer stripe_attributes: :stripe_attributes

  has_one :profile

  def stripe_attributes(pay_customer)
    {
      metadata: {
        pay_customer_id: pay_customer.id,
        user_id: id # or pay_customer.owner_id
      }
    }
  end
end
