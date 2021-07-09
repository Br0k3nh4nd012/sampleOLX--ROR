class RemoveLocationFromProduct < ActiveRecord::Migration[6.1]
  def change
    remove_reference :products, :location, null: false, foreign_key: true
  end
end
