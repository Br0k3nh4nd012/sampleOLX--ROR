class Product < ApplicationRecord




  belongs_to :user
  has_one :payment , dependent: :destroy
  has_one :location ,as: :locatable, dependent: :destroy
  # belongs_to :location
  has_many :favourites
  has_many :users , through: :favourites
  has_and_belongs_to_many :categories , foreign_key: 'product_id' , dependent: :destroy
  belongs_to :brand

def location_city
  location.city.cityName
end
def location_state
  location.state.stateName
end
def location_country
  location.country.countryName
end
def brandname
  brand.brandName
end


  #scopes--------------
  # default_scope { order(created_at: :asc) }
  scope :other_products , ->(current_user) { where("user_id != ?" , current_user.id)}
  
  
  attribute :soldOut, :boolean, default: false

  #validations-----------------
  validates :name , :description, :price ,:user_id ,presence: true
  validates :price , numericality: { greater_than: 0 }
  

  after_update do    
    validates_presence_of :buyerId if self.soldOut?
  end

def favProduct(user)
  self.users.include? user
end

end


