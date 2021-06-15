class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  default_scope { order(created_at: :asc) }

  has_many :products , dependent: :destroy
  has_many :payments , dependent: :destroy

  validates :mobNumber, length: { is: 10 }
  # validates :name ,:mobNumber ,:address ,  presence: true

  # validates :mobNumber , presence: true
  # validates :address , presence: true

end
