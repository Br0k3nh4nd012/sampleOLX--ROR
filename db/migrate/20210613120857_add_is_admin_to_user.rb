class AddIsAdminToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :isAdmin, :boolean , :default => false
  end
end
