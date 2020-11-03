class CreateEventPictures < ActiveRecord::Migration[5.2]
  def change
    create_table :event_pictures do |t|
      t.string :picture
      t.references :event, foreign_key: true

      t.timestamps
    end
  end
end
