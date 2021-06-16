class Payment < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :user, :paymentMethod,:product , presence: true
  # validates :paymentMethod, exclusion: { in: %w(select),
  #   message: "select a valid payment option" }

    # validates :size, inclusion: { in: %w(small medium large),
    # message: "%{value} is not a valid size" }
end
