class User < ApplicationRecord
  after_create :create_profile

  rolify :role_cname => 'Owner'
  rolify :role_cname => 'Admin'
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :trackable,
         :omniauthable, omniauth_providers: [:google_oauth2, :facebook]

  has_many :properties, foreign_key: "owner_id", dependent: :destroy

  has_many :reservations, dependent: :destroy
  has_many :reserved_properties, through: :reservations, source: :property

  pay_customer stripe_attributes: :stripe_attributes

  has_one :profile, dependent: :destroy

  has_many :notifications, as: :recipient

  has_many :reviews, dependent: :destroy

  def stripe_attributes(pay_customer)
    {
      metadata: {
        pay_customer_id: pay_customer.id,
        user_id: id # or pay_customer.owner_id
      }
    }
  end

  def create_profile 
    Profile.create(
      name: self.email,
      user_id: self.id
    )
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email 
      user.password = Devise.friendly_token[0, 20]
      user.skip_confirmation!
    end
  end
end
