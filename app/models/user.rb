class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  default_scope { order(created_at: :asc) }

  has_many :products , dependent: :destroy
  has_many :payments , dependent: :destroy

  validates :mobNumber, length: { is: 10 ,message: "Enter a valid Mobile Number" },on: :update
  # validates :mobNumber, format: { with: /\A[0-9]+\z/,
  #   message: "only allows digits" }
    # or 
  validates :mobNumber, numericality: {  message: "only allows digits"},on: :update

  validates :name , :address , length: { minimum: 3 , message: "Enter a valid %{attribute}"} ,on: :update
  # validates :mobNumber , presence: true
  validates :name , :address , :mobNumber , presence: true, on: :update
  # validates :mobNumber , presence: true
  # validates :address , presence: true

  #callbacks-----------------------

  

end
