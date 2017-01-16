class Element < ActiveRecord::Base

  belongs_to :bucket
  belongs_to :user
  has_many :posts


  # def user
  #   self.bucket.user
  # end



end