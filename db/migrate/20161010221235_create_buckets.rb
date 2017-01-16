class CreateBuckets < ActiveRecord::Migration
  def change
    create_table :buckets do |x|
      x.string :title
      x.integer :user_id
    end
  end
end
