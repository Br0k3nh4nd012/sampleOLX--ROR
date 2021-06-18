class Location < ApplicationRecord
  belongs_to :product

  validates :city , :state , :country , :postalCode , presence:true
  validates :postalCode, length: { is: 6 }
  validates :postalCode, format: { with: /\A[0-9]+\z/,
  message: "only allows digits" }

  before_create :checkProduct
  def checkProduct
    if self.product_id
      return true
    else
      self.errors.add(:product_id , "No product found to add location")
      return false
  end
end
end
