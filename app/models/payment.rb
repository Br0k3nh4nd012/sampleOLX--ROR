class Payment < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :paymentMethod , :user, :product , presence: true
end
