class AddUseridToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :userid, :integer
  end
end
