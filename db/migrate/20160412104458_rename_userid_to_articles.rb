class RenameUseridToArticles < ActiveRecord::Migration
  def change
    rename_column :articles, :userid, :user_id
  end
end
