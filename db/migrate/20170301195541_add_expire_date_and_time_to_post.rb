class AddExpireDateAndTimeToPost < ActiveRecord::Migration
  def change
    add_column :posts, :expire_date, :date
    add_column :posts, :expire_time, :time
  end
end
