class RemoveColumnsLocatableFromLocation < ActiveRecord::Migration[6.1]
  def change
    remove_column :locations, :locatable_id, :integer
    remove_column :locations, :locatable_type, :string
  end
end
