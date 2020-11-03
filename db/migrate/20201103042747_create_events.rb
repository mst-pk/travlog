class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.references :user, foreign_key: true
      t.string :title
      t.text :comment
      t.date :event_date
      t.string :address
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
