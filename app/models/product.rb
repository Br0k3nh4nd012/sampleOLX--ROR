class Product < ApplicationRecord
  belongs_to :user
  has_one :payment 
  has_one :location
  default_scope { order(created_at: :asc) }
  
  validates :name , presence: true
  validates :category , presence: true
  validates :description , presence: true
  validates :price , presence: true
end
