class CreateLocations < ActiveRecord::Migration[6.1]
  def change
    create_table :locations do |t|
      t.string :city
      t.string :state
      t.string :country
      t.integer :postalCode
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
