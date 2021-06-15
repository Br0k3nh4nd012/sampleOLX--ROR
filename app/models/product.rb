class Product < ApplicationRecord
  belongs_to :user
  has_one :payment , dependent: :destroy
  has_one :location , dependent: :destroy

  default_scope { order(created_at: :asc) }
  
  validates :name ,:category, :description, :price,  presence: true
  validates :soldOut, exclusion: [nil]
  # validates :category , presence: true
  # validates :description , presence: true
  # validates :price , presence: true
end
