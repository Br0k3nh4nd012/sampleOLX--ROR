class RemoveColumnsFromLocation < ActiveRecord::Migration[6.1]
  def change
    remove_column :locations, :city, :string
    remove_column :locations, :state, :string
    remove_column :locations, :country, :string
  end
end
