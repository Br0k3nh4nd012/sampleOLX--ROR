class AddLocationToProducts < ActiveRecord::Migration[6.1]
  def change
    add_reference :products, :location, null: false, foreign_key: true
  end
end
