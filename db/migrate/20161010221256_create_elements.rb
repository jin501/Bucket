class CreateElements < ActiveRecord::Migration
  def change
    create_table :elements do |x|
      x.string :content
      x.boolean :completed, default: false
      x.string :title
      x.integer :bucket_id
      x.integer :user_id
      x.string :picture
    end
  end
end
