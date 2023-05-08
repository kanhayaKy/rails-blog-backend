class RenameDescriptionToContentAndAddTitleToPosts < ActiveRecord::Migration[7.0]
  def change
    rename_column :posts, :description, :content
    add_column :posts, :title, :string, null: false
    change_column :posts, :likes, :integer, default: 0
  end
end
