class ChangeReadDefaultToMessageUser < ActiveRecord::Migration[6.1]
  def change
    change_column :message_users, :read, :boolean, :default => false
  end
end
