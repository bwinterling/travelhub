class ChangeOriginColumnToStringInStatuses < ActiveRecord::Migration
  def change
    remove_column :statuses, :origin_id, :integer
    add_column :statuses, :origin_id, :string
  end
end
