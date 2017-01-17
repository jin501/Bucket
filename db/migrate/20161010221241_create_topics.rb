class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |x|
      x.string :hashtag
    end
  end
end
