class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :description
      t.datetime :expire_time
      t.string :offer_type

      t.timestamps null: false
    end
  end
end
