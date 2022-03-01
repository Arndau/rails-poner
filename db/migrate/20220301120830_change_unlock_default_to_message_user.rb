class ChangeUnlockDefaultToMessageUser < ActiveRecord::Migration[6.1]
  def change
    change_column :message_users, :unlocked, :boolean, :default => false
  end
end
