class AddIndexToPhotosForTakenDate < ActiveRecord::Migration
  def change
    add_index :photos, :photo_taken
  end
end
