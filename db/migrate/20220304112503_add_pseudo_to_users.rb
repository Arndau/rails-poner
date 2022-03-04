class AddPseudoToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :pseudo, :string
  end
end
