class CreateTravels < ActiveRecord::Migration[5.2]
  def change
    create_table :travels do |t|
      t.string :title
      t.string :travel_image
      t.integer :genre
      t.date :start_time
      t.date :end_time
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
