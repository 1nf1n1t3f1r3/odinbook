class RemoveUserFromComments < ActiveRecord::Migration[8.1]
  def change
    remove_column :comments, :user, :string
  end
end
