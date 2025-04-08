class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :validatable


  validates :email, presence: true, uniqueness: true

  enum role: { customer: 0, admin: 1 }
  has_many :bookings

  def admin?
    role == "admin"
  end
end
