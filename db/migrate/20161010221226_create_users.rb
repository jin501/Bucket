class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |x|
      x.string :full_name
      x.string :username
      x.string :email
      x.string :avatar
      x.string :password_digest
    end
  end
end
