class RemovePriceFromPayment < ActiveRecord::Migration[6.1]
  def change
    remove_column :payments, :price, :integer
  end
end
