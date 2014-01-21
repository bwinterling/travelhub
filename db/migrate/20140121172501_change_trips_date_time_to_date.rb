class ChangeTripsDateTimeToDate < ActiveRecord::Migration
  def change
   add_column :trips, :starts_on, :date
   add_column :trips, :ends_on, :date
   remove_column :trips, :starts_at
   remove_column :trips, :ends_at
  end
end
