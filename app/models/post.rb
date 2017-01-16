class Post < ActiveRecord::Base

  belongs_to :user
  belongs_to :bucket
  belongs_to :element
  

end