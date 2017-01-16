class Topic < ActiveRecord::Base 
  
  belongs_to :user
  has_many :bucket_topics
  has_many :buckets, through: :bucket_topics

end