class AddUserAndPostToComments < ActiveRecord::Migration[8.1]
  def change
    add_reference :comments, :user, null: false, foreign_key: true
    add_reference :comments, :post, null: false, foreign_key: true
  end
end
