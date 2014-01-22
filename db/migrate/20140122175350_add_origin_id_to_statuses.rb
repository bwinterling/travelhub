class AddOriginIdToStatuses < ActiveRecord::Migration
  def change
    add_column :statuses, :origin_id, :integer
  end
end
