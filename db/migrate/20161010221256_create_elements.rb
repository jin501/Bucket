class CreateElements < ActiveRecord::Migration
  def change
    create_table :elements do |x|
      x.string :content
      x.integer :bucket_id
      x.integer :user_id
    end
  end
end
