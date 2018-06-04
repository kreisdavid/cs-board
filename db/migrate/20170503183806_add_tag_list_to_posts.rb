class AddTagListToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :tag_list, :string, :default => [] 
  end
end
