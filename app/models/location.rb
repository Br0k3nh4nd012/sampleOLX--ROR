class Location < ApplicationRecord
  belongs_to :locatable , polymorphic: true

  validates :city , :state , :country , :postalCode , presence:true
  validates :postalCode, length: { is: 6 }
  validates :postalCode, format: { with: /\A[0-9]+\z/,
  message: "only allows digits" }

 

  scope :in_location , ->(loc) { where("city == ?" , loc)}




  before_create :checkProduct
  def checkProduct
    if self.locatable_type=='Product'
      return true
    else
      self.errors.add(:locatable_id , "No product found to add location")
      return false
  end
end
end
