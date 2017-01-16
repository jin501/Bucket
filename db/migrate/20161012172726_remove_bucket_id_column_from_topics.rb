class RemoveBucketIdColumnFromTopics < ActiveRecord::Migration
  def change
    remove_column(:topics, :bucket_id)
  end
end
