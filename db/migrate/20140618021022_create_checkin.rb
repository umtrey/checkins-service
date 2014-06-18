class CreateCheckin < ActiveRecord::Migration
  def change
    create_table :checkins do |t|
      t.integer     :user_id
      t.integer     :location_id
      t.datetime    :created_at
    end

    add_index :checkins, :user_id
    add_index :checkins, :location_id
  end
end
