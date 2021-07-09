class AddCityStateCountryToLocation < ActiveRecord::Migration[6.1]
  def change
    add_reference :locations, :city, null: false, foreign_key: true
    add_reference :locations, :state, null: false, foreign_key: true
    add_reference :locations, :country, null: false, foreign_key: true
  end
end
