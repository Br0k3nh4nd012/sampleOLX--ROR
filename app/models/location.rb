class Location < ApplicationRecord
  belongs_to :product

  validates :city , :state , :country , :postalCode , presence:true
  validates :postalCode, length: { is: 6 }
end
