class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_one :point, dependent: :destroy, as: :resource

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def facebook_url
    "https://facebook.com/#{uid}"
  end
end
