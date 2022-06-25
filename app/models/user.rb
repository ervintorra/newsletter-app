class User < ApplicationRecord
  USER_ROLES = {
    user: 'user',
    admin: 'admin'
  }.freeze
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable, :trackable

  has_many :newsletters

  enum role: USER_ROLES

  def full_name
    "#{first_name} #{last_name}"
  end
end
