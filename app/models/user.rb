class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  acts_as_paranoid

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  default_scope { order(created_at: :asc) }

  has_many :products , class_name:"Product", dependent: :destroy
  has_many :payments , dependent: :destroy
  has_many :favourites
  has_many :favourite_products ,  through: :favourites , source: :product

  validates :mobNumber, length: { is: 10 ,message: "Enter a valid Mobile Number" },on: :update
  # validates :mobNumber, format: { with: /\A[0-9]+\z/ message: "only allows digits" }

  validates :mobNumber, numericality: {  message: "only allows digits"},on: :update
  # validates :mobNumber, uniqueness: true ,on: :update
  validates :name , :address , length: { minimum: 3 , message: "Enter a valid %{attribute}"} ,on: :update
  # validates :mobNumber , presence: true
  validates :name , :address , :mobNumber , presence: true, on: :update
  # validates :mobNumber , presence: true
  # validates :address , presence: true

  #doorkeeper=---------------------
  def self.authenticate(email, password)
    user = User.find_for_authentication(email: email)
    user&.valid_password?(password) ? user : nil
  end

  def active_for_authentication?
    super && !self.isBlocked
  end
  def inactive_message
    "Sorry, this account is not active."
  end


  #callbacks-----------------------

  before_create do
    puts self.email
  end

  before_update :makeCapital
  def makeCapital
    self.name = name.capitalize if !self.name.blank?
    self.address = address.capitalize
  end

  after_update do 
    puts self.name
  end



  def self.current
    Thread.current[:user]
  end
  def self.current=(user)
    Thread.current[:user] = user
  end
end
