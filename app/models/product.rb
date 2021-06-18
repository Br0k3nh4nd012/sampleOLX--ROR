class Product < ApplicationRecord
  belongs_to :user
  has_one :payment , dependent: :destroy
  has_one :location , dependent: :destroy
  #scopes--------------
  default_scope { order(created_at: :asc) }
  scope :other_products , ->(current_user) { where("user_id != ?" , current_user.id)}

  #validations-----------------
  validates :name ,:category, :description, :price,  presence: true
  # validates :soldOut, exclusion: [nil]


  #callbacks-----------------
  before_create :setSoldOut
  def setSoldOut
    self.soldOut = false
  end

  
  before_destroy :checkUser
  def checkUser
    if self.user.isAdmin || self.user = User.current
      return true
    else
      return false
    end
  end

  # validates :category , presence: true
  # validates :description , presence: true
  # validates :price , presence: true
  
end
