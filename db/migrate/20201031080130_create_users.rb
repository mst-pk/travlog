class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :image
      t.string :background_image
      t.integer :gender
      t.date :birthday
      t.text :about

      t.timestamps
    end
  end
end
