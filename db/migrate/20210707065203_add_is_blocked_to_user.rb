class AddIsBlockedToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :isBlocked, :boolean
  end
end
