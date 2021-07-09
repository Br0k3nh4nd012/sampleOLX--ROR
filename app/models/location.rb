class Location < ApplicationRecord
  belongs_to :locatable , polymorphic: true

  # has_many :products
  belongs_to :city
  belongs_to :state
  belongs_to :country

  validates :city , :state , :country , :postalCode , presence:true
  validates :postalCode, length: { is: 6 }
  validates :postalCode, format: { with: /\A[0-9]+\z/, message: "only allows digits" }

  
 



end
