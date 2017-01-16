class Bucket < ActiveRecord::Base

  belongs_to :user
  has_many :topics, through: :bucket_topics
  has_many :bucket_topics
  has_many :elements
  has_many :posts

end