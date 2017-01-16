class BucketTopic < ActiveRecord::Base

  belongs_to :bucket
  belongs_to :topic


end