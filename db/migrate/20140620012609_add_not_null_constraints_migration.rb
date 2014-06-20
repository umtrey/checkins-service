class AddNotNullConstraintsMigration < ActiveRecord::Migration
  def change
    change_column_null :checkins, :user_id, false
    change_column_null :checkins, :location_id, false
  end
end
