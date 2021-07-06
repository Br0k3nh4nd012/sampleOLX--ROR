class Product < ApplicationRecord
  belongs_to :user
  has_one :payment , dependent: :destroy
  has_one :location ,as: :locatable, dependent: :destroy
  #scopes--------------
  # default_scope { order(created_at: :asc) }
  scope :other_products , ->(current_user) { where("user_id != ?" , current_user.id)}
  
  
  attribute :soldOut, :boolean, default: false

  #validations-----------------
  validates :name ,:category, :description, :price ,:user_id ,presence: true
  validates :price , numericality: { greater_than: 0 }
  # validates :soldOut, exclusion: [nil]


  #callbacks-----------------
  # before_create :setSoldOut
  # def setSoldOut
  #   self.soldOut = false
  # end

  after_update do
    # if self.soldOut 
    #   !self.buyerId.nil? 
    # end
    validates_presence_of :buyerId if self.soldOut?
    # self.buyerId.present?  if self.soldOut?
    # self.errors.add(:buyerId , "buyer Id cannot be nil!!")
  end
  # before_update :checkUser
  
  # before_destroy :checkUser
  # def checkUser
  #   if self.user.isAdmin || self.user == User.current
  #     return true
  #   else
  #     return false
  #   end
  # end

  
  # validates :category , presence: true
  # validates :description , presence: true
  # validates :price , presence: true
  
end

# validate_presence_of :validate_units_array, :unless => Proc.new { |p| p.record_attribute_changed?("status", "before") && discarded?}
