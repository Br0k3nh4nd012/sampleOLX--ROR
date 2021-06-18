class Location < ApplicationRecord
  belongs_to :product

  validates :city , :state , :country , :postalCode , presence:true
  validates :postalCode, length: { is: 6 }
  validates :postalCode, format: { with: /\A[0-9]+\z/,
  message: "only allows digits" }
end
