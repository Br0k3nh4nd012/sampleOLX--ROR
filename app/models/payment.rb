class Payment < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :user, :paymentMethod,:product , presence: true
  validates :product ,uniqueness: true
  # validates :paymentMethod, exclusion: { in: %w(select),
  #   message: "select a valid payment option" }

    # validates :size, inclusion: { in: %w(small medium large),
    # message: "%{value} is not a valid size" }

    after_save :updateProduct

    def updateProduct
      prod = Product.find(self.product.id)
      prod.buyerId = self.user.id
      prod.soldOut = true
      prod.save
    end

    before_create :manipulatePayMethod
    def manipulatePayMethod
      self.paymentMethod = paymentMethod.byteslice(19..-3)
    end
end
