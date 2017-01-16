class CreateBucketTopicsTable < ActiveRecord::Migration
  def change
    create_table :bucket_topics do |x|
      x.integer :buket_id
      x.integer :topic_id
    end
  end
end
