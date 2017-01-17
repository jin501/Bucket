class Topic < ActiveRecord::Base

  belongs_to :bucket
  has_many :bucket_topics
  has_many :buckets, through: :bucket_topics

end
