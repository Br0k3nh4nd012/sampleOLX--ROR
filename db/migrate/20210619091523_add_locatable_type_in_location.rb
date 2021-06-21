class AddLocatableTypeInLocation < ActiveRecord::Migration[6.1]
  def change
    add_column :locations ,:locatable_type , :string
  end
end
