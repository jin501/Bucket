class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |x|
      x.string :hashtag
      x.integer :bucket_id
    end
  end
end
