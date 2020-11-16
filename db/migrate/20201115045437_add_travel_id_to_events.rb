class AddTravelIdToEvents < ActiveRecord::Migration[5.2]
  def change
    add_reference :events, :travel, foreign_key: true
  end
end
