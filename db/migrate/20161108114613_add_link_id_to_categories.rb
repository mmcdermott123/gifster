class AddLinkIdToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :link_id, :integer
  end
end
