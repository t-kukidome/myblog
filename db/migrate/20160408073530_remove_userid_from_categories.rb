class RemoveUseridFromCategories < ActiveRecord::Migration
  def change
    remove_column :categories, :userid, :integer
  end
end
