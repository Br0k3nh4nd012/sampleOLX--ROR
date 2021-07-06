class Location < ApplicationRecord
  belongs_to :locatable , polymorphic: true

  # has_many :products
  belongs_to :city
  belongs_to :state
  belongs_to :country

  validates :city , :state , :country , :postalCode , presence:true
  validates :postalCode, length: { is: 6 }
  validates :postalCode, format: { with: /\A[0-9]+\z/, message: "only allows digits" }

 

#   scope :in_location , ->(loc) { where("city == ?" , loc)}


  # def city
  #   city.cityName
  # end

# before_create :checkProduct
#   def checkProduct
#     if self.locatable_type=='Product'
#       return true
#     else
#       self.errors.add(:locatable_id , "No product found to add location")
#       return false
#   end
# end
end
