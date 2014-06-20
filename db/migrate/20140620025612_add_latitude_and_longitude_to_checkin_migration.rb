class AddLatitudeAndLongitudeToCheckinMigration < ActiveRecord::Migration
  def change
    add_column :checkins, :latitude,  :decimal
    add_column :checkins, :longitude, :decimal
  end
end
