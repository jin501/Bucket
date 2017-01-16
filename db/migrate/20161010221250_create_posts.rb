class CreatePosts < ActiveRecord::Migration
  def change
      create_table :posts do |x|
        x.string :blob
        x.integer :element_id
        x.integer :bucket_id
        x.integer :user_id
    end
  end
end
