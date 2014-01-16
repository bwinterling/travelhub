class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.references :user, index: true
      t.text :check_in
      t.text :friends
      t.text :photos
      t.text :venuehistory
      t.text :todos

      t.timestamps
    end
  end
end
