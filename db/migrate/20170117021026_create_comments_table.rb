class CreateCommentsTable < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |x|
      x.string :comment
      x.integer :user_id
      x.integer :element_id
    end
  end
end
