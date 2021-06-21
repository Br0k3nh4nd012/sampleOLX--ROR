class ProductIdToLocatableIdInLocation < ActiveRecord::Migration[6.1]
  def change
    rename_column :locations , :product_id , :locatable_id
  end
end
