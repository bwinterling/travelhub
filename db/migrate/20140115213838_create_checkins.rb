class CreateCheckins < ActiveRecord::Migration
  def change
    create_table :checkins do |t|
      t.references :user, index: true
      t.string :venue_name
      t.string :venue_street_address
      t.decimal :venue_latitude, {:precision=>10, :scale=>6}
      t.decimal :venue_longitude, {:precision=>10, :scale=>6}
      t.string :shout
      t.datetime :checkins_at

      t.timestamps
    end
  end
end
